terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.13.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "6.13.0"
    }
  }
}
data "google_compute_subnetwork" "subnet" {
  name = var.subnetwork
  region = var.region
  project = var.project_id
}

data "google_compute_instance" "main"{
  for_each = {
    "<your vm instace name>" = var.zone
    "<My-web-aplication-01>" = var.zone
  }

  name = each.key
  zone = each.value
  project = var.project_id
}

resource "google_compute_instance_group" "instance_group" {
  name = var.group_name
  project = var.project_id
  zone = var.zone
  description = "Instance group for load balancing"

  instances = [for instance in data.google_compute_instance.main : instance.self_link]

  named_port {
    name = "http"
    port = 80
  }
}
resource "google_compute_health_check" "lb_health_check" {
  name = var.health_check_name
  project = var.project_id
  check_interval_sec = 5
  timeout_sec = 5
  healthy_threshold = 2
  unhealthy_threshold = 2

  http_health_check {
    port = 80
    request_path = "/health"
  }
}

resource "google_compute_backend_service" "lb_backend_service" {
  name = var.backend_service_name
  project = var.project_id
  protocol = "HTTP"
  health_checks = [google_compute_health_check.lb_health_check.self_link]
  timeout_sec = 30
  port_name = "http"

  backend {
    group = google_compute_instance_group.instance_group.self_link
  }
}

resource "google_compute_url_map" "lb_url_map" {
  name = var.url_map_name
  project = var.project_id
  default_service = google_compute_backend_service.lb_backend_service.self_link
}

resource "google_compute_target_http_proxy" "lb_http_proxy" {
  name = var.http-proxy-name
  project = var.project_id
  url_map = google_compute_url_map.lb_url_map.self_link
}

resource "google_compute_global_forwarding_rule" "lb_fronted" {
  name = var.frontend_name
  project = var.project_id
  target = google_compute_target_http_proxy.lb_http_proxy.self_link
  port_range = "80"
  ip_protocol = "TCP"
}