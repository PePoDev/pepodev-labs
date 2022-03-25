output "machine_names" {
  value       = vagrant_vm.this.machine_names
  description = "value"
}

output "forwarded_ports" {
  value       = vagrant_vm.this.ports
  description = "value"
}

output "ssh_config" {
  value       = vagrant_vm.this.ssh_config
  description = "value"
}
