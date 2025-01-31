terraform {
  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "6.13.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "6.13.0"
    }
  }
}

provider "google" {
  project = var.project
  region = var.region
  credentials = file("../Key/<your-key-in-json>")
}