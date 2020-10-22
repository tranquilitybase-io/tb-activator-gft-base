terraform {
backend "gcs" {
  bucket = google_storage_bucket.terraform.name  # GCS bucket name to store terraform tfstate
  prefix = "tf_admin"  # Prefix name should be unique for each Terraform project having same remote state bucket.
  }
}