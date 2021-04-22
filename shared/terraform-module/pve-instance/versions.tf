terraform {
  required_version = ">= 0.13"
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.6.5"
    }
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "1.24.2"
    }
  }
}
