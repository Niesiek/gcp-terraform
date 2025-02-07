variable "project" {
  type = string
}
variable "environement" {
  type = string
}
variable "region" {
  type = string
}

variable "admin_password" {
  type = string
  sensitive = true
}
variable "mysql_user_password" {
  type = string
  sensitive = true
}
variable "allowed_ips" {
  type = list(string)
}