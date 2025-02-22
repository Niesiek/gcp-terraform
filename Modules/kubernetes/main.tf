resource "google_container_cluster" "primary" {
  for_each = toset([for i in range(var.claster_count) : "k8s-cluster-${i + 1}"])

  name                = each.key
  project             = var.project
  location            = var.region
  deletion_protection = false

  private_cluster_config {
    enable_private_nodes    = var.enable_private_nodes
    enable_private_endpoint = false
  }

  node_pool {
    name               = "default-pool"
    initial_node_count = 1
    autoscaling {
      min_node_count = var.node_min_count
      max_node_count = var.node_max_count
    }
    node_config {
      machine_type = var.node_machine_type
      oauth_scopes = [
        "https://www.googleapis.com/auth/cloud-platform"
      ]
    }
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = var.trusted_ip_range
      display_name = "Trusted IP Range"
    }
  }

  network    = "your-vpc-network"
  subnetwork = "your-vpc-subnetwork"
  # For example:
  #   network = "prod-vpc"
  #   subnetwork = "prod-subnet-01"
}
