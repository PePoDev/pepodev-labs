module "kind_cluster" {
  source = "../../shared/terraform-module/kind-cluster"

  cluster_name          = "horizontal-pod-autoscaler-lab"
  enable_loadbalancer   = true
  enable_metrics_server = true
}

resource "kubernetes_deployment" "nginx_deployment" {
  metadata {
    name = "nginx-example"
    labels = {
      app = "nginx"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }

      spec {
        container {
          name  = "nginx"
          image = "nginx"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          port {
            container_port = 80
          }
        }

        container {
          name  = "busybox"
          image = "busybox"

          command = ["watch ls"]
        }
      }
    }
  }
}

resource "kubernetes_horizontal_pod_autoscaler" "example" {
  metadata {
    name = "nginx-hpa"
  }

  spec {
    min_replicas = 1
    max_replicas = 10

    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = "nginx-example"
    }

    metric {
      type = "Resource"
      resource {
        name = "cpu"
        target {
          type                = "Utilization"
          average_utilization = "40"
        }
      }
    }
  }
}
