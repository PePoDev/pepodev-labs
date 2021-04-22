resource "kind_cluster" "this" {
  name           = var.cluster_name
  node_image     = "${var.node_image}:v${var.kubernetes_version}"
  wait_for_ready = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    dynamic "node" {
      for_each = var.enable_loadbalancer ? concat(var.nodes, [{ role : "external-load-balancer", kubeadm_config_patches : [] }]) : var.nodes
      content {
        role = node.value["role"]
      }
    }

    containerd_config_patches = var.containerd_config_patches
  }
}

resource "kubectl_manifest" "kubectl_apply_metrics_server" {
  count     = var.enable_metrics_server ? length(data.kubectl_file_documents.metrics_server_manifests[0].documents) : 0
  yaml_body = element(data.kubectl_file_documents.metrics_server_manifests[0].documents, count.index)
}

data "kubectl_file_documents" "metrics_server_manifests" {
  count   = var.enable_metrics_server ? 1 : 0
  content = file("${path.module}/kubernetes/metrics-server.yml")
}
