module "firewall" {
  source = "../../../Modules/firewall"
  network_name = "${var.environment}-vpc"
  project = var.project
  allow_firewall_rules = var.allow_firewall_rules

}