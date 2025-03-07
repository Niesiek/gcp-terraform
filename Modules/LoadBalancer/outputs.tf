output "load_balancer_public_ip" {
  description = "Public address of the load balancer"
  value = google_compute_global_forwarding_rule.lb_fronted.ip_address
}

output "load_balancer_endpoint" {
  description = "URL or endpoint of the load balancer"
  value = "http://${google_compute_global_forwarding_rule.lb_fronted.ip_address}"
}