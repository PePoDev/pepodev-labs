provider "proxmox" {
  pm_api_url      = var.proxmox_credentials.api_url
  pm_user         = var.proxmox_credentials.user
  pm_password     = var.proxmox_credentials.password
  pm_tls_insecure = true
  pm_otp          = ""
  pm_parallel     = 2
  pm_timeout      = 600
}

provider "vsphere" {
  vsphere_server       = var.vsphere_credentials.server
  user                 = var.vsphere_credentials.user
  password             = var.vsphere_credentials.password
  allow_unverified_ssl = true
}


data "vsphere_datacenter" "dc" {
  name = local.vsphere_dc_name
}

data "vsphere_compute_cluster" "cluster" {
  name          = local.vsphere_cluster_name
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_datastore" "esx_vsan_storage" {
  name          = local.vsphere_datastore_vsan_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "esx_ssd_storage" {
  count = length(local.vsphere_datastore_ssd_names)
  name          = local.vsphere_datastore_ssd_names[count.index]
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = local.vsphere_pool_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = local.vsphere_network_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_content_library" "library" {
  name = "ISO/OVA Library"
}

data "vsphere_content_library_item" "template" {
  name       = local.vsphere_template_clone
  library_id = data.vsphere_content_library.library.id
}
