terraform {
  required_providers {
    kind = {
      source  = "kyma-incubator/kind"
      version = ">= 0.0.7"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.10.0"
    }
  }
}
