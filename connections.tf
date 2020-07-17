provider "google" {
  credentials = file("/opt/app/data/service-account.json")
  #credentials = file("../service-account.json")
  project     = var.host_project_id
  region      = var.region
  zone        = var.zone
}

