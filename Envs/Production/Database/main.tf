module "database" {
  source = "../../../Modules/Database"
  admin_password = var.admin_password
  allowed_ips = var.allowed_ips
  environement = var.environement
  mysql_user_password = var.mysql_user_password
  project = var.project
  region = var.region
}