resource "vagrant_vm" "this" {
  id              = null
  vagrantfile_dir = "${path.module}/${var.os_name}"
  get_ports       = false

  env = {
    VAGRANTFILE_HASH = md5(file("${path.module}/${var.os_name}/Vagrantfile")),
  }
}
