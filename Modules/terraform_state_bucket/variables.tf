variable "name_prefix" {
  description = "Prefix for the bucket"
  type = string
}

variable "environment" {
  description = "The environment name (e.g. production)"
  type = string
}

variable "location" {
  description = "The location where the bucket will be created"
  type = string
  default = "US"
}

variable "log_bucket_name" {
  description = "The bucket to store access logs"
  type = string
  default = null
}