module "vagrant_coreos" {
  source = "../../shared/terraform-module/vagrant-vm"

  os_name = "coreos"
}
