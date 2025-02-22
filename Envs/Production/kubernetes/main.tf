module "kubernetes" {
  source               = "../../../Modules/kubernetes"
  project              = var.project
  region               = var.region
  cluster_count        = var.cluster_count
  node_machine_type    = var.node_machine_type
  node_min_count       = var.node_min_count
  node_max_count       = var.node_max_count
  trusted_ip_range     = var.trusted_ip_range
  enable_private_nodes = var.enable_private_nodes
}
