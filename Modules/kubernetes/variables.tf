variable "claster_count" {
  description = "Number of Kubernetes clusters to create"
  type        = number
}

variable "project" {
  description = "The ID of the project to deploy resources in."
  type        = string
}

variable "enable_private_nodes" {
  description = "Enable private nodes for GKE clusters"
  type        = string
}

variable "region" {
  description = "The region for GKE claster"
  type        = string
}

variable "node_machine_type" {
  description = "Machine type for the node pool"
  type        = string
  default     = "e2-medium"
}

variable "node_min_count" {
  description = "Minimum number of the nodes for autoscaling"
  type        = number
}

variable "node_max_count" {
  description = "Maximum number of the nodes for autoscaling"
  type        = number
}

variable "trusted_ip_range" {
  description = "CIDR block for trusted IP range for API access"
  type        = string
}

variable "enable_private_endpoint" {
  description = "Enable private endpoint for GKE clusters"
  type        = bool
  default     = true
}
