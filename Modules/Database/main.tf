terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.13.0"
    }
  }
}
resource "google_sql_database_instance" "mysql_sb" {
  database_version = "MYSQL_8_0" # Here you can change your mysql version
  deletion_protection = true
  region = var.region
  project = var.project

  settings {
    tier = var.tier

    ip_configuration {
      ipv4_enabled = true

      dynamic "authorized_networks" {
        for_each = var.allowed_ips
        iterator = server
        content {
          name = "authorized_network-${server.value}"
          value = server.value
        }
      }
    }
  }
}

resource "google_sql_user" "admin" {
  name = "admin"
  password = var.admin_password
  project = var.project
}

resource "google_sql_user" "mysql_user" {
  name = "mysql_user"
  password = var.mysql_user_password
  project = var.project
}
resource "google_sql_database" "app_database" {
  name = var.database_name
  project = var.project

  lifecycle {
    prevent_destroy = true # now terraform don't delete database
  }
}