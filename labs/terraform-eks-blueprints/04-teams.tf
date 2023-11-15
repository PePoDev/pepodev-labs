module "development_team" {
  source  = "aws-ia/eks-blueprints-teams/aws"
  version = "~> 1.1"
  for_each = {
    # team_one = {
    #   users = ["arn:aws:iam::012345678901:role/developers-one"]
    # }
    # team_two = {
    #   users = ["arn:aws:iam::012345678901:role/developers-two"]
    # }
  }

  name              = "${each.key}-team"
  users             = each.value.users
  cluster_arn       = module.eks.cluster_arn
  oidc_provider_arn = module.eks.oidc_provider_arn

  labels = {
    team = each.key
  }

  annotations = {
    team = each.key
  }

  namespaces = {
    default = {
      create = false
    }

    (each.key) = {
      labels = {
        projectName = "project-awesome",
      }

      # https://kubernetes.io/docs/concepts/policy/resource-quotas/
      resource_quota = {
        hard = {
          "requests.cpu"    = "1000m",
          "requests.memory" = "4Gi",
          "limits.cpu"      = "2000m",
          "limits.memory"   = "8Gi",
          "pods"            = "10",
          "secrets"         = "10",
          "services"        = "10"
        }
      }

      # https://kubernetes.io/docs/concepts/policy/limit-range/
      limit_range = {
        limit = [
          {
            type = "Pod"
            max = {
              cpu    = "200m"
              memory = "1Gi"
            }
          },
          {
            type = "PersistentVolumeClaim"
            min = {
              storage = "24M"
            }
          },
          {
            type = "Container"
            default = {
              cpu    = "50m"
              memory = "24Mi"
            }
          }
        ]
      }

      # https://kubernetes.io/docs/concepts/services-networking/network-policies/
      network_policy = {
        pod_selector = {
          match_expressions = [
            {
              key      = "name"
              operator = "In"
              values   = ["front", "api"]
            }
          ]
        }

        ingress = [
          {
            ports = [
              {
                port     = "http"
                protocol = "TCP"
              },
              {
                port     = "53"
                protocol = "TCP"
              },
              {
                port     = "53"
                protocol = "UDP"
              }
            ]

            from = [
              {
                namespace_selector = {
                  match_labels = {
                    name = "default"
                  }
                }
              },
              {
                ip_block = {
                  cidr = "10.0.0.0/8"
                  except = [
                    "10.0.0.0/24",
                    "10.0.1.0/24",
                  ]
                }
              }
            ]
          }
        ]

        egress = []

        policy_types = ["Ingress", "Egress"]
      }
    }
  }
}
