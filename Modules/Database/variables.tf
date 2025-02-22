variable "region" {
  type    = string
  default = "us-central1"
}
variable "tier" {
  type    = string
  default = "db-f1-micro"
}
variable "ennvironment" {
  type = string
}

variable "admin_password" {
  type      = string
  sensitive = true
}

variable "mysql_user_password" {
  type      = string
  sensitive = true
}

variable "allowed_ips" {
  description = "List of authorized IP addresses or CIDR blocks"
  type        = list(string)
}

variable "project" {
  type = string
}

variable "database_name" {
  type = string
}

variable "environment" {
  type = string
}
