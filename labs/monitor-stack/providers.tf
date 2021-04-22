terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "~> 2.0"
    }
  }
}

provider "proxmox" {
  pm_api_url      = "https://pve.opsta.in.th/api2/json"
  pm_user         = "thiwanon@pve"
  pm_password     = "pepo0616670989"
  pm_tls_insecure = true
  pm_parallel     = 1
}
