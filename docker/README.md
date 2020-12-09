# Tranqility Base Activator for Importing Data into Google Cloud Platform (GCP) [Docker Variant]

The tb-activator-gft-base repo has been developed to provide a general template for the creation of new activator repos. 
As well as considerably accelerating development, this will ensure cross-comparability and uphold consistent standards for any activator repo. 
For example, the tb-activator-gft-datazone repository is based on the template outlined here.

The activator can be installed either through the docker package (recommended) or via the underlying source code. 
Both of these are available in the repository. For ease of installation, we recommend using the docker packages to install base activator.  

Currently a single example package is available:
*   tb-activator-gft-base - a base image to demonstrate how to build future activators

## Resources:
Running this package builds the following infrastructure resources in GCP:

### GCE (Google Cloud Compute)

Virtual machines that can be used to perform ETL tasks. This activator creates 1 virtual machine. 
The types of machine can be configured at terraform apply stage using the following variable:

vms_machine_type: Machine type of the virtual both machines, example 'n1-standard-2'

### GCS (Google Cloud Storage)

In this activator, we create one google storage buckets.
landing-data-bucket: To be used for landing incoming data.
