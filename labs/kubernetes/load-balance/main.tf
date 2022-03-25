module "kind_cluster" {
  source = "../../shared/terraform-module/kind-cluster"

  cluster_name          = "load-balance-lab"
  enable_loadbalancer   = true
  enable_metrics_server = true
}

resource "kubernetes_pod" "pod_foo" {
  metadata {
    name = "foo-app"
    labels = {
      "app" = "http-echo"
    }
  }

  spec {
    container {
      name  = "foo-app"
      image = "hashicorp/http-echo:0.2.3"
      args  = ["-text=foo"]
    }
  }
}

resource "kubernetes_pod" "pod_bar" {
  metadata {
    name   = "bar-app"
    labels = kubernetes_pod.pod_foo.metadata.0.labels
  }

  spec {
    container {
      name  = "bar-app"
      image = "hashicorp/http-echo:0.2.3"
      args  = ["-text=bar"]
    }
  }
}

resource "kubernetes_service" "foo_service" {
  metadata {
    name = "foo-service"
  }
  spec {
    type     = "LoadBalancer"
    selector = kubernetes_pod.pod_foo.metadata.0.labels
    port {
      port = 5678
    }
  }
}
