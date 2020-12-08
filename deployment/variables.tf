
variable "vm1_name" {
  description = "Name of the first virtual machine, example 'asset-vm-1'"
  default = "vm1"
}

variable "vms_machine_type" {
  description = "Machine type of the virtual machines, example 'n1-standard-2'"
  type    = string
  default = "n1-standard-2"
}

variable "vms_size" {
  description = "VMs sizes (storage) in GB, example 200."
  type    = number
  default = 20
}

variable "host_project_id" {
  description = "Project ID, example 'data-science-activator'"
  default = "default"
}

variable "landing_bucket_name" {
  description = "Name of the storage bucket for incoming data, example 'landing-data-bucket'."
  type    = string
  default = "landing-data-bucket-mssb-sandbox"
}

variable "region" {
  description = "General location of the project, example 'europe-west2'"
  default     = "europe-west2"
}

variable "zone" {
  description = "General zone of the project, example 'europe-west2-b'"
  default     = "europe-west2-b"
}

variable "standard_subnetwork" {
  description = "VPC subnetwork such as main-network-subnet"
  default     = "default"
}

