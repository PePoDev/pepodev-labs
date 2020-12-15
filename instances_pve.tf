module "pve_instances_k8s_masters" {
  count  = length(var.pve_k8s_masters)
  source = "./modules/pve-vm"

  name           = "pepo-k8s-master-${count.index + 1}"
  vm_id          = var.pve_k8s_masters[count.index].vm_id
  target_node    = var.pve_k8s_masters[count.index].target_node
  template_clone = local.pve_template_clone
  pool           = local.pve_pool_name
  cores          = 4
  memory         = 4096

  networks = [
    {
      model     = "virtio"
      bridge    = "vmbr0"
      macaddr   = null
      tag       = null
      firewall  = null
      rate      = null
      queues    = null
      link_down = null
    }
  ]

  disks = [
    {
      type        = "scsi"
      storage     = "pve-nfs"
      size        = "30G"
      format      = "raw"
      cache       = null
      backup      = null
      iothread    = null
      replicate   = null
      ssd         = null
      discard     = null
      mbps        = null
      mbps_rd     = null
      mbps_rd_max = null
      mbps_wr     = null
      mbps_wr_max = null
      file        = null
      media       = null
      volume      = null
      slot        = null
    }
  ]

  cloud_init_provisioning = {
    user          = local.username
    nameserver    = local.pve_nameserver
    sshkeys       = local.ssh_pubkeys
    wait          = null
    password      = null
    custom        = null
    search_domain = null
    ipconfig = [
      {
        ipv4_cidr = var.pve_k8s_masters[count.index].ipv4_cidr
        gateway   = local.pve_gateway
      }
    ]
  }
}

module "pve_instances_k8s_workers" {
  count  = length(var.pve_k8s_workers)
  source = "./modules/pve-vm"

  name           = "pepo-k8s-worker-${count.index + 1}"
  vm_id          = var.pve_k8s_workers[count.index].vm_id
  target_node    = var.pve_k8s_workers[count.index].target_node
  template_clone = local.pve_template_clone
  pool           = local.pve_pool_name
  cores          = 4
  memory         = 4096

  networks = [
    {
      model     = "virtio"
      bridge    = "vmbr0"
      macaddr   = null
      tag       = null
      firewall  = null
      rate      = null
      queues    = null
      link_down = null
    }
  ]

  disks = [
    {
      type        = "scsi"
      storage     = "pve-nfs"
      size        = "30G"
      format      = "raw"
      cache       = null
      backup      = null
      iothread    = null
      replicate   = null
      ssd         = null
      discard     = null
      mbps        = null
      mbps_rd     = null
      mbps_rd_max = null
      mbps_wr     = null
      mbps_wr_max = null
      file        = null
      media       = null
      volume      = null
      slot        = null
    }
  ]

  cloud_init_provisioning = {
    user          = local.username
    nameserver    = local.pve_nameserver
    sshkeys       = local.ssh_pubkeys
    wait          = null
    password      = null
    custom        = null
    search_domain = null
    ipconfig = [
      {
        ipv4_cidr = var.pve_k8s_workers[count.index].ipv4_cidr
        gateway   = local.pve_gateway
      }
    ]
  }
}
