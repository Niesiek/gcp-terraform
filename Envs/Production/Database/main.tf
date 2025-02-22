module "database" {
  database_name       = var.database_name
  source              = "../../../Modules/Database"
  admin_password      = var.admin_password
  allowed_ips         = var.allowed_ips
  environment         = var.environment
  mysql_user_password = var.mysql_user_password
  project             = var.project
  region              = var.region
}
