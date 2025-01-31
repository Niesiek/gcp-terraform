terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.13.0"
    }
  }
}
resource "google_storage_bucket" "static-site" {
  location = var.location
  name     = var.name

  website {
    main_page_suffix = var.main_page_suffix
    not_found_page = var.not_fount_page
  }
  force_destroy = var.force_destroy

  versioning {
    enabled = var.versioning
  }
}

resource "google_storage_bucket_object" "starting_page" {
  name     = "index.html"
  bucket   = google_storage_bucket.static-site.name
  source = "${path.module}/files/index.html"
  content_type = "text/html"
}

resource "google_storage_bucket_object" "not_found_page" {
  name   = "404.html"
  bucket = google_storage_bucket.static-site.name
  source = "${path.module}/files/404.html"
  content_type = "text/html"
}