output "username" {
  description = "User Name"
  value       = var.cloud_init_provisioning
}

output "ip_0" {
  description = "IP Address"
  value       = split("/", var.cloud_init_provisioning.ipconfig.0.ipv4_cidr)[0]
}

output "hostname" {
  description = "Hostname"
  value       = var.name
}
