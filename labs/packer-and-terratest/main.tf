variable "aws_region" {
  type    = string
  default = "ap-southeast-1"
}

variable "instance_name" {
  type    = string
  default = "terratest-packer"
}

variable "instance_type" {
  type    = string
  default = "c4.large"
}

variable "ami_id" {
  type = string
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.1"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.12"

  name = var.instance_name
  cidr = "10.77.0.0/16"

  azs            = ["ap-southeast-1a"]
  public_subnets = ["10.77.101.0/24"]

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform   = "true"
    Environment = "terratest"
  }
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.2"

  name = var.instance_name

  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [module.node_exporter_sg.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "terratest"
  }
}

module "node_exporter_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.8"

  name   = var.instance_name
  vpc_id = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 9100
      to_port     = 9100
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}

output "instance_url" {
  value = "http://${module.ec2_instance.public_dns}:9100"
}
