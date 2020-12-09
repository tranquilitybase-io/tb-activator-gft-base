
# GFT (Generic) Base Activator Repository [Source Code Variant]

The tb-activator-gft-base repo has been developed to provide a general template for the creation of new activator repos.  As well as considerably accelerating development, this will ensure cross-comparability and uphold consistent standards for any activator repo.  For example, the tb-activator-gft-datazone repository is based on the template outlined here.

The activator can be installed either through the docker package (recommended) or via the underlying source code. Both of these are available in the repository. 

This README file describes installation using underlying source code. The 'Docker' folder provides instructions for installation using the docker package.

## Installation: Deploying Base Activator (Using Source Code)

Although using the docker package is recommended, using the underlying source code is also feasible.  However, in this case, it is necessary to have terraform installed and project and service accounts already created.

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
* Update the following variable in variables.tf:
```hcl-terraform
variable "host_project_id" {
  description = "Project ID, example 'data-science-activator'"
  default     = ""
}
variable "zone" {
  description = "General zone of the project, example 'europe-west2-b'"
  default     = ""
}
variable "standard_subnetwork" {
  description = "VPC subnetwork such as main-network-subnet"
  default     = ""
}
variable "region" {
  description = "General location of the project, example 'europe-west2'"
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
    
 
  
### Resources:
#### GCE (Google Cloud Compute) 
Virtual machines that can be used to perform ETL tasks. This activator creates 1 virtual machines. The types of machine can be
 configured at terraform apply stage using the following variable:
 
 ```
 vms_machine_type: Machine type of the virtual both machines, example 'n1-standard-2'
 ``` 

#### GCS (Google Cloud Storage)
In this activator, we creates one google storage buckets. 
 * landing-data-bucket: To be used for landing incoming data.
 
