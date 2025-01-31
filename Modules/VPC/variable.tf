variable "name" {
  description = "The name of the VPC"
  type = string
}
variable "project" {
  description = "Project name"
  type = string
}
variable "description" {
  description = "Description of the VPC"
  type = string
}
variable "auto_create_subnetworks" {
  description = "Whether to auto-create subnetworks"
  type = bool
  default = false
}
variable "routing_mode" {
  description = "Routing mode for the VPC"
  type = string
}
variable "subnets" {
  description = "Map of the subnets to create"
  type = map(object({
    cidr = string
    region = string
    private_ip_google_access = bool
  }))
}
