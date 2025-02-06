project = "<Your_project_ID>"
region = "<Region to deploy instances>"
environment = "<your_environment>"
# Here enter your subnet where your instances will run,
# it will run in the same subnet as your work environment
# for example here we use the subnet for 10.0.2.0
subnetwork_ip_cidr_range = "10.0.2.0/24"

compute_engines = {
  # Your instance name:
  "MyFirstInstanceGCP" = {
    # Define your machine type, it will use the most basic instance
    machine_type = "f1-micro"
    # Define where the virtual machine will run
    machine_location = "us-central1-a"
    # You can but don't must, define tags for your vm
    network_tags = ["app", "https-server"]
    # Note if your virtual machine needs a public address
    external_ip = true
    # VM description (optional)
    machine_description = "Web application instance"
    # Here you define the final address of the machine,
    # if you want the machine to have a local address of 10.0.2.2,
    # you must use ip_host = 2
    ip_host = 2
  }
  # Now try it yourself
  "<instance_name>"={
    machine_type = ""
    machine_location = ""
    network_tags = ["", ""]
    external_ip = true/false
    machine_description = ""
    ip_host = 3
  }
}
