variable "project" {
  type = string
}

variable "region" {
  type = string
}

variable "cluster_count" {
  type    = number
  default = 1
}

variable "node_machine_type" {
  type    = string
  default = "n1-standard-2"
}
variable "node_min_count" {
  type    = number
  default = 1
}
variable "node_max_count" {
  type = number
}

variable "trusted_ip_range" {
  type = string
}
variable "enable_private_nodes" {
  type = string
}
