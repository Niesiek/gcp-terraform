module "load_balancer" {
  source = "../../../Modules/LoadBalancer"
  backend_service_name = var.backend_service_name
  frontend_name = var.frontend_name
  group_name = var.group_name
  health_check_name = var.health_check_name
  http_proxy_name = var.http_proxy_name
  project_id = var.project_id
  region = var.region
  subnetwork = var.subnetwork
  url_map_name = var.url_map_name
  zone = var.zone
}