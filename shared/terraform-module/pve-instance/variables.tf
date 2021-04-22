variable "proxmox_credentials" {
  type = object({
    api_url  = string
    user     = string
    password = string
  })
}

variable "vsphere_credentials" {
  type = object({
    server   = string
    user     = string
    password = string
  })
}

variable "pve_k8s_masters" {
  type = list(object({
    vm_id       = string
    target_node = string
    ipv4_cidr   = string
  }))
  default = []
}

variable "pve_k8s_workers" {
  type = list(object({
    vm_id       = string
    target_node = string
    ipv4_cidr   = string
  }))
  default = []
}
