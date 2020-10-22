# Create terrafom state bucket

# module "gcs-bucket" {
#   source  = "terraform-google-modules/cloud-storage/google"
#   version = "~> 1.7"
#   name        = "${var.gcs_bucket_prefix}-${var.tb_discriminator}"
#   project_id  = module.shared_projects.shared_telemetry_id
#   location    = var.region
# }


resource "google_storage_bucket" "terraform" {
  name               = "${var.terraform_bucket_name}-${var.host_project_id}"
  bucket_policy_only = true
  force_destroy      = true
  location           = var.region
  
  versioning {
    enabled = true
  }
}

resource "google_storage_bucket_object" "artifacts" {
  name = "artifacts/"
  bucket = google_storage_bucket.terraform.name
  source = ".tb/"


}