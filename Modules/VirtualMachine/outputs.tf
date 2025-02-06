output "instance_ips" {
  value = {for name, instance in google_compute_instance.main : name => instance.network_interface[0].network_ip} # The actual value to be outputted
  description = "The public IP address of the instance" # Description of what this output represents
}
output "instance_external_ips" {
  description = "The external IP addresses of the created instance"
  value = {for name, instance in google_compute_instance.main : name => instance.network_interface[0].access_config}
}
output "instance_names" {
  description = "The names of the created instances"
  value = { for name, instance in google_compute_instance.main : name => instance.name }
}