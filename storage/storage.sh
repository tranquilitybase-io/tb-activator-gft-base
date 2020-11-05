terraform init 
terraform plan -out storage-plan -var='host_project_id=$projectid' -var='activator_name=$activator_name'
terraform apply --auto-approve storage-plan
