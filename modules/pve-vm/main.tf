resource "proxmox_vm_qemu" "vm_qemu" {
  name        = var.name
  target_node = var.target_node
  vmid        = var.vm_id
  desc        = var.description

  bios       = var.bios
  onboot     = var.onboot
  boot       = var.boot
  bootdisk   = var.bootdisk
  agent      = var.agent
  iso        = var.iso
  clone      = var.template_clone
  full_clone = var.full_clone
  hastate    = var.hastate
  qemu_os    = var.qemu_os
  memory     = var.memory
  balloon    = var.balloon
  cores      = var.cores
  sockets    = var.sockets
  vcpus      = var.vcpus
  cpu        = var.cpu
  numa       = var.numa
  hotplug    = var.hotplug
  scsihw     = var.scsihw

  dynamic "vga" {
    for_each = var.vgas
    content {
      type   = vga.value["type"]
      memory = vga.value["memory"]
    }
  }

  dynamic "network" {
    for_each = var.networks
    content {
      model     = network.value["model"]
      macaddr   = network.value["macaddr"]
      bridge    = network.value["bridge"]
      tag       = network.value["tag"]
      firewall  = network.value["firewall"]
      rate      = network.value["rate"]
      queues    = network.value["queues"]
      link_down = network.value["link_down"]
    }
  }

  dynamic "disk" {
    for_each = var.disks
    content {
      type        = disk.value["type"]
      storage     = disk.value["storage"]
      size        = disk.value["size"]
      format      = disk.value["format"]
      cache       = disk.value["cache"]
      backup      = disk.value["backup"]
      iothread    = disk.value["iothread"]
      replicate   = disk.value["replicate"]
      ssd         = disk.value["ssd"]
      discard     = disk.value["discard"]
      mbps        = disk.value["mbps"]
      mbps_rd     = disk.value["mbps_rd"]
      mbps_rd_max = disk.value["mbps_rd_max"]
      mbps_wr     = disk.value["mbps_wr"]
      mbps_wr_max = disk.value["mbps_wr_max"]
      file        = disk.value["file"]
      media       = disk.value["media"]
      volume      = disk.value["volume"]
      slot        = disk.value["slot"]
    }
  }

  dynamic "serial" {
    for_each = var.serials
    content {
      id   = serial.value["id"]
      type = serial.value["type"]
    }
  }

  pool         = var.pool
  force_create = var.force_create
  clone_wait   = var.clone_wait
  os_type      = var.os_type

  # for Linux for preprovisioning.
  # os_network_config = var.linux_provisioning.os_network_config
  # ssh_forward_ip    = var.linux_provisioning.ssh_forward_ip
  # ssh_host          = var.linux_provisioning.ssh_host
  # ssh_port          = var.linux_provisioning.ssh_port
  # ssh_user          = var.linux_provisioning.ssh_user
  # ssh_private_key   = var.linux_provisioning.ssh_private_key

  # Cloud-init for preprovisioning.
  ci_wait      = var.cloud_init_provisioning.wait
  ciuser       = var.cloud_init_provisioning.user
  cipassword   = var.cloud_init_provisioning.password
  cicustom     = var.cloud_init_provisioning.custom
  searchdomain = var.cloud_init_provisioning.search_domain
  nameserver   = var.cloud_init_provisioning.nameserver
  sshkeys      = <<EOF
${join("\n", var.cloud_init_provisioning.sshkeys)}
EOF
  ipconfig0    = length(var.cloud_init_provisioning.ipconfig) > 0 ? "ip=${var.cloud_init_provisioning.ipconfig[0].ipv4_cidr},gw=${var.cloud_init_provisioning.ipconfig[0].gateway}" : null
  ipconfig1    = length(var.cloud_init_provisioning.ipconfig) > 1 ? "ip=${var.cloud_init_provisioning.ipconfig[1].ipv4_cidr},gw=${var.cloud_init_provisioning.ipconfig[1].gateway}" : null
  ipconfig2    = length(var.cloud_init_provisioning.ipconfig) > 2 ? "ip=${var.cloud_init_provisioning.ipconfig[2].ipv4_cidr},gw=${var.cloud_init_provisioning.ipconfig[2].gateway}" : null

  lifecycle {
    ignore_changes = []
  }

  provisioner "remote-exec" {
    inline = [
      "set -e",
      "echo 'cloud-init is running'",
      "cloud-init status --wait > /dev/null 2>&1",
      "[ $? -ne 0 ] && echo 'cloud-init failed' && exit 1",
      "echo 'cloud-init succeeded'",
    ]
  }

  connection {
    type        = "ssh"
    user        = var.cloud_init_provisioning != null ? var.cloud_init_provisioning.user : var.linux_provisioning.ssh_user
    host        = var.cloud_init_provisioning != null ? split("/", var.cloud_init_provisioning.ipconfig[0].ipv4_cidr)[0] : var.linux_provisioning.ssh_forward_ip
    private_key = file(var.private_key_file)
  }
}
