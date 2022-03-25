resource "kind_cluster" "this" {
  name           = var.cluster_name
  node_image     = "${var.node_image}:v${var.kubernetes_version}"
  wait_for_ready = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    dynamic "node" {
      for_each = var.nodes
      content {
        role = node.value["role"]
        # TODO: add support for more node option [https://github.com/kyma-incubator/terraform-provider-kind/blob/83d5502462e9ec33d4fa26c41a3ccf80d6cee0f4/kind/schema_kind_config.go#L76]
        # image = null
        # extra_mounts {
        #   host_path      = null
        #   container_path = null
        # }
        # extra_port_mappings {
        #   container_port = null
        #   host_port      = null
        #   listen_address = null
        #   protocol       = null
        # }
        # kubeadm_config_patches = null
      }
    }

    # TODO: Add support networking option [https://github.com/kyma-incubator/terraform-provider-kind/blob/83d5502462e9ec33d4fa26c41a3ccf80d6cee0f4/kind/schema_kind_config.go#L31]
    # networking {
    #   ip_family           = null
    #   api_server_address  = null
    #   api_server_port     = null
    #   pod_subnet          = null
    #   service_subnet      = null
    #   disable_default_cni = null
    #   kube_proxy_mode     = null
    # }

    containerd_config_patches = var.containerd_config_patches
  }
}
