# specify provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
    subscription_id = ""
  features {
  }
}


# create rg
resource "azurerm_resource_group" "resource_group" {
    location = "uksouth"
    name = "rg-terraform"
}

# storage account
resource "azurerm_storage_account" "storage_account" {
    account_replication_type = "LRS"
    account_tier = "Standard"
    location = azurerm_resource_group.resource_group.location
    name = "andriusdal232323"
    resource_group_name = azurerm_resource_group.resource_group.name
}

# create blob container
resource "azurerm_storage_container" "container" {
    name = "testblob"
    storage_account_name = azurerm_storage_account.storage_account.name
    container_access_type = "private"
    
}

# upload random file
resource "azurerm_storage_blob" "blobcontent" {
    name = "fulldeploy.json"
    storage_account_name = azurerm_storage_account.storage_account.name
    storage_container_name = azurerm_storage_container.container.name
    type = "Block"
    source_uri = "https://raw.githubusercontent.com/andriusdalgeda/bicep/refs/heads/main/vpnGateway/fullDeploy.json"
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


