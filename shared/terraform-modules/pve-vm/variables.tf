variable "private_key_file" {
  type        = string
  description = "Path to ssh private key file"
  default     = "~/.ssh/id_rsa"
}

variable "name" {
  type        = string
  description = "Name of the VM"
}

variable "target_node" {
  type        = string
  description = "Node to place the VM on"
}

variable "vm_id" {
  type        = number
  description = "ID of the VM in Proxmox, defaults to next number in the sequence"
  default     = null
}

variable "description" {
  type        = string
  description = "Description of the VM"
  default     = null
}

variable "define_connection_info" {
  type        = string
  description = "Define the (SSH) connection parameters for preprovisioners, see config block below."
  default     = true
}

variable "bios" {
  type        = string
  description = "BIOS to use for this VM, default is seabios"
  default     = "seabios"
}

variable "onboot" {
  type    = bool
  default = true
}

variable "boot" {
  type    = string
  default = "cdn"
}

variable "bootdisk" {
  type    = string
  default = "scsi0"
}

variable "agent" {
  type    = number
  default = 0
}

variable "iso" {
  type    = string
  default = null
}

variable "template_clone" {
  type        = string
  description = "The name of the VM to clone into a new VM"
  default     = null
}

variable "full_clone" {
  type    = bool
  default = true
}

variable "hastate" {
  type    = string
  default = null
}

variable "qemu_os" {
  type        = string
  description = "(optional) describe your variable"
  default     = "l26"
}

variable "memory" {
  type    = number
  default = 1024
}

variable "balloon" {
  type    = number
  default = 0
}

variable "cores" {
  type    = number
  default = 1
}

variable "sockets" {
  type    = number
  default = 1
}

variable "vcpus" {
  type    = number
  default = 0
}

variable "cpu" {
  type    = string
  default = "host"
}

variable "numa" {
  type    = bool
  default = true
}

variable "kvm" {
  type    = bool
  default = true
}

variable "hotplug" {
  type    = string
  default = "network,disk,usb"
}

variable "scsihw" {
  type    = string
  default = "virtio-scsi-pci"
}

variable "vgas" {
  type = list(object({
    type   = string
    memory = number
  }))
  description = "GPUs Configuration"
  default = [{
    type   = "std"
    memory = 0
  }]
}

variable "networks" {
  type = list(object({
    model     = string
    macaddr   = string
    bridge    = string
    tag       = number
    firewall  = bool
    rate      = number
    queues    = number
    link_down = bool
  }))
  description = "Networks configuration"
  default     = []
}

variable "disks" {
  type = list(object({
    type        = string
    storage     = string
    size        = string
    format      = string
    cache       = string
    backup      = bool
    iothread    = bool
    replicate   = bool
    ssd         = bool
    discard     = string
    mbps        = number
    mbps_rd     = number
    mbps_rd_max = number
    mbps_wr     = number
    mbps_wr_max = number
    file        = string
    media       = string
    volume      = string
    slot        = number
    file        = string
    media       = string
    volume      = string
    slot        = number
  }))
  description = "Disks configuration"
  default     = []
}

variable "serials" {
  type = list(object({
    id   = string
    type = string
  }))
  description = "Serials configuration"
  default     = []
}

variable "pool" {
  type    = string
  default = null
}

variable "force_create" {
  type    = bool
  default = true
}

variable "clone_wait" {
  type    = number
  default = null
}

variable "os_type" {
  type        = string
  description = "Which provisioning method to use, based on the OS type. Possible values: ubuntu, centos, cloud-init."
  default     = "cloud-init"
}

variable "linux_provisioning" {
  type = object({
    os_network_config = string
    ssh_forward_ip    = string
    ssh_host          = string
    ssh_port          = string
    ssh_user          = string
    ssh_private_key   = string
  })
  description = ""
  default = {
    os_network_config = null
    ssh_forward_ip    = null
    ssh_host          = null
    ssh_port          = null
    ssh_user          = null
    ssh_private_key   = null
  }
}

variable "cloud_init_provisioning" {
  type = object({
    wait          = string
    user          = string
    password      = string
    custom        = string
    search_domain = string
    nameserver    = string
    sshkeys       = list(string)
    ipconfig = list(object({
      ipv4_cidr = string
      gateway   = string
    }))
  })
  description = ""
  default     = null
}
