output "instance_ips" {
  description = "The internal IP addresses of the created instances"
  value = module.VirtualMachine.instance_ips
}

output "instance_external_ips" {
  description = "The external IP addresses of the created instances"
  value = module.VirtualMachine.instance_external_ips
}

output "instance_names" {
  description = "The names of the created instances"
  value = module.VirtualMachine.instance_names
}