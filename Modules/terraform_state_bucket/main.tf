terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.13.0"
    }
  }
}
resource "google_storage_bucket" "terraform_state" {
  location = var.location
  name     = "${var.name_prefix}-terraform-state-${var.environment}"

  # For have versions of the state file, we will eneble versioning
  versioning {
    enabled = true
  }
  # Set the lifecycle rule for the state file. If the file has fewer than 1 newer
  # version or it has existed for more than 90 days, it will be deleted.
  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 90
      num_newer_versions = 1
      matches_storage_class = ["STANDARD"]
    }
  }
  # Enable uniform bucket-level access for better access control
  uniform_bucket_level_access = true


  # Prevent accidental destruction of the Terraform state bucket
  lifecycle {
    prevent_destroy = true
  }
  # Configure logging for the bucket, specifying the log destination and prefix.
  logging {
    log_bucket = var.log_bucket_name
    log_object_prefix = "logs/"
  }
  # Assign labels to the bucket for better identification (e.g., environment and purpose).
  labels = {
    environment = var.environment
    purpose = "terraform-state"
  }
}