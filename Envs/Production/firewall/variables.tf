variable "environment" {
  type = string
}
variable "project" {
  type = string
}
variable "allow_firewall_rules" {
  description = "Map of firewall rules to allow"
  type = map(object({
    desctiption = string
    priority = number
    protocol = string
    ports = optional(list(string))
    source_ip_ranges = optional(list(string))
    tags = optional(list(string))
  }))
}