variable "host_project_id" {
  description = "Project ID, example 'data-science-activator'"
}

variable "region" {
  description = "General location of the project, example 'europe-west2'"
  default     = "europe-west2"
}

variable "zone" {
  description = "General zone of the project, example 'europe-west2-b'"
  default     = "europe-west2-b"
}

variable "activator_name" {
  description = "Activator name which will be used as part of GCS Terraform state bucket name"
}
