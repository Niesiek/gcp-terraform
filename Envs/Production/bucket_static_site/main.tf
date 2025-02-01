module "static_site" {
  source = "../../../Modules/bucket_static_site"
  name = var.name
  location = var.location
  force_destroy = true
  version = true
  main_page_suffix = "index.html"
  not_fount_page = "404.html"
}