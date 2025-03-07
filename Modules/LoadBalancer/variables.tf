variable "project_id" {
  description = "The ID of the project where this VPC will be created"
  type        = string
  default = "<here paste your project ID>"
}

variable "region" {
  description = "The region in which resources will be created"
  type        = string
}

variable "zone" {
  description = "The zone in which the resources will be created"
  type        = string
  default     = "<paste your zone-region>"
  # for example: us-central-a
}

variable "subnetwork" {
  type        = string
}

variable "group_name" {
  type        = string
}
variable "backend_service_name" {
  type        = string
}
variable "health_check_name" {
  type = string
}

variable "url_map_name" {
  type        = string
}

variable "http-proxy-name" {
  type        = string
}

variable "frontend_name" {
  type        = string
}