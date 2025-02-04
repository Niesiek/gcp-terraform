environment = "production"
project = "<your_project>"
allow_firewall_rules = {
  # Here you can add your firewall rules
  "allow-http" ={
    "protocol" = "tcp"
    "ports" = ["80"]
    "priority" = "1000"
    "tags" = ["http-server"]
    "description" = "Allow http communication"
    "source_ip_ranges" = ["0.0.0.0/0"]
  }

  # How to add ssh communication?
  "allow-ssh-vpn"={
    "protocol" = "tcp"
    "ports" = ["22"]
    "priority" = "1001"
    "description" = "Allow ssh communication"
    "source_ip_ranges" = [
    # Here add your public ip address with mask /32
      # only when you want to connect from one PC, for example
      "86.17.32.170/32"
    ]
  }

}