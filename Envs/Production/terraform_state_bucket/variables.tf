variable "name_prefix" {
  description = "Prefix for resource"
  type = string
}

variable "environment" {
  type = string
}

variable "location" {
  description = "Location of the bucket"
  type = string
  default = "US"
}

variable "log_bucket_name" {
  description = "Name of logs in bucket"
  type = string
}
