variable "compute_engines" {
  description = "Map of compute engine instances to create, keyed by instance name."
  type = map(object({
    machine_type = string
    machine_description = optional(string)
    machine_location = string
    network_tags = optional(list(string))
    ip_host = number
  }))
}

variable "subnetwork_ip_cidr_range" {
  description = "The CIRD range for the subnetwork"
  type = string
}

variable "project" {
  description = "The ID of the project to deploy resources in."
  type = string
}

variable "region" {
  type = string
}

variable "environment" {
  description = "Type of environment"
  type = string
}