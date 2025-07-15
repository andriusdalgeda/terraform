deploy

terraform init

terraform plan (or terraform plan -out "tfplan" to save plan)

terraform apply

terraform validate

terraform destroy


tf state stored in azure storage account
remote back end

backend.tf

.tfvars
variables.tf

terraform fmt

terraform plan -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars"