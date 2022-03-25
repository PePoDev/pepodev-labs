module "kind_cluster" {
  source = "../../shared/terraform-module/kind-cluster"

  cluster_name          = "horizontal-pod-autoscaler-lab"
  enable_metrics_server = true
}

resource "helm_release" "hpa_example" {
  name  = "hpa-example"
  chart = "./hpa-chart"
}
