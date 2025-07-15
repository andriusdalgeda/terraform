# create rg
resource "azurerm_resource_group" "resource_group" {
  location = var.location
  name     = var.resource_group_name
}

# storage account
resource "azurerm_storage_account" "storage_account" {
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = var.location
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
}

# create blob container
resource "azurerm_storage_container" "container" {
  name                  = var.container_name
  storage_account_name  = var.storage_account_name
  container_access_type = "private"

}

# upload random file
resource "azurerm_storage_blob" "blobcontent" {
  name                   = "fulldeploy.json"
  storage_account_name   = var.storage_account_name
  storage_container_name = var.container_name
  type                   = "Block"
  source_uri             = var.blob_source_uri
}

/* 
deploy

terraform init

terraform plan (or terraform plan -out "tfplan" to save plan)

terraform apply

terraform validate

terraform destroy


tf state stored in azure storage account
remote back end

backend.tf

*/


