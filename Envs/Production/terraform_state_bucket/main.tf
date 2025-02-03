module "terraform-state-bucket" {
  source = "../../../Modules/terraform_state_bucket"

  name_prefix = var.name_prefix
  environment = var.environment
  location = var.location
  log_bucket_name = var.log_bucket_name
}