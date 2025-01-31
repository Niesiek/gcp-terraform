variable "name" {
  description = "The name of the storage bucket"
  type = string
}
variable "location" {
  description = "Location of the storage bucket"
  type = string
}
variable "force_destroy" {
  description = "Whether to force destroy the storage bucket"
  type = bool
  default = true
}
variable "versioning" {
  description = "Whether to eneble versioning for the storage bucket"
  type = bool
  default = true
}

variable "main_page_suffix" {
  description = "The suffix for the main page of the website"
  type = string
  default = "index.html"
}
variable "not_fount_page" {
  description = "The name of the 404 not found page"
  type = string
  default = "404.html"
}