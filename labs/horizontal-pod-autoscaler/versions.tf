terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.1"
    }
    kind = {
      source  = "kyma-incubator/kind"
      version = "~> 0.0.7"
    }
  }
}
