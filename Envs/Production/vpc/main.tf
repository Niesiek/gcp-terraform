module "VPC" {
  source = "../../../Modules/VPC"

  name  = var.environment
  project = var.project
  description = "${var.environment} evnironment VPC"
  routing_mode = "Global"

  subnets = {
    "${var.environment}-subnet-01" = {
      cidr = "<your_ip_range>"
      region = "<your_compute_region>"
      private_ip_google_access = true
    },
    "${var.environment}-subnet-02" = {
      cidr = "10.0.1.0/24"
      region = "us-central2"
      private_ip_google_access = true
    },
    "${var.environment}-subnet-03" = {
      cidr = "<your_ip_range>"
      region = "<your_compute_region>"
      private_ip_google_access = true
    },
  }
}