package test

import (
	"crypto/tls"
	"fmt"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/packer"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"

	terratest_aws "github.com/gruntwork-io/terratest/modules/aws"
	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
)

func TestPacker(t *testing.T) {
	workingDir := "."
	awsRegion := terratest_aws.GetRandomStableRegion(t, []string{"ap-southeast-1"}, nil)
	instanceType := terratest_aws.GetRecommendedInstanceType(t, awsRegion, []string{"c4.large"})

	amiID := packer.BuildArtifact(t, &packer.Options{
		Template: workingDir,
		Vars: map[string]string{
			"aws_region":    awsRegion,
			"ami_prefix":    "terratest",
			"instance_type": instanceType,
		},
	})
	defer terratest_aws.DeleteAmiAndAllSnapshots(t, awsRegion, amiID)

	uniqueID := random.UniqueId()
	instanceName := fmt.Sprintf("terratest-packer-%s", uniqueID)
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: workingDir,
		Vars: map[string]interface{}{
			"aws_region":    awsRegion,
			"instance_name": instanceName,
			"instance_type": instanceType,
			"ami_id":        amiID,
		},
	})
	terraform.InitAndApply(t, terraformOptions)
	defer terraform.Destroy(t, terraformOptions)

	instanceURL := terraform.Output(t, terraformOptions, "instance_url")
	http_helper.HttpGetWithRetryWithCustomValidation(t, instanceURL, &tls.Config{}, 10, 5*time.Second,
		func(status int, body string) bool {
			return status == 200
		})
}
