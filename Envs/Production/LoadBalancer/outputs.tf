output "load_balancer_ip" {
  description = "The public IP of the load balancer, which is attached to the load balancer."
  value = module.load_balancer.load_balancer_public_ip
}

output "load_balancer_endpoint" {
  description = "Endpoint of the Load Balancer"
  value = module.load_balancer.load_balancer_endpoint
}