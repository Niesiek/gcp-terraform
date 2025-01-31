variable "project" {
  description = "GCP project name"
  type        = string
}
variable "region" {
  description = "GCP network region"
  type = string
  default = "us-central1"
}