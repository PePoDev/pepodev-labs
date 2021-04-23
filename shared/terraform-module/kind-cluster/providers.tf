provider "kubectl" {
  load_config_file       = false
  host                   = kind_cluster.this.endpoint
  client_certificate     = kind_cluster.this.client_certificate
  client_key             = kind_cluster.this.client_key
  cluster_ca_certificate = kind_cluster.this.cluster_ca_certificate
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}
