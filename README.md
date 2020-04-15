
# Deploying data landing zone

Pre-requisite to build the data science environment is to build the shared
-components infrastructures, and also terraform has been installed and project and service accounts have already been created.

After that please follow the following steps:

* Update connections.tf and add your service account file (json) to provider "google
", full directory to the your file shall be added to file("").
```hcl-terraform
provider "google" {
  credentials = file("")
  project     = var.cluster_project_id
  region      = var.region
}
```
* Update variables.tf and add your project_id to the following in default = "":
```hcl-terraform
variable "host_project_id" {
  description = "Project ID, example 'data-science-activator'"
  default     = ""
}
```

You can run terraform as follow:
```shell script
terraform init

terraform validate
 
terraform plan 

terraform apply
```

This activator builds the following components:
    
 
  
## Resources:
### GCE (Google Cloud Compute) 
Virtual machines that can be used to perform ETL tasks. This activator creates 1 virtual machines. The types of machine can be
 configured at terraform apply stage using the following variable:
 
 ```
 vms_machine_type: Machine type of the virtual both machines, example 'n1-standard-2'
 ``` 

### GCS (Google Cloud Storage)
In this activator, we creates one google storage buckets. 
 * landing-data-bucket: To be used for landing incoming data.
 