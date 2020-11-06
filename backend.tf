terraform {
backend "gcs" {
    credentials = "/opt/app/data/service-account.json"
  }
}
