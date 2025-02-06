module "VirtualMachine" {
  source = "../../../Modules/VirtualMachine"

  compute_engines = var.compute_engines
  subnetwork_ip_cidr_range = var.subnetwork_ip_cidr_range
  region = var.region
  project = var.project
}