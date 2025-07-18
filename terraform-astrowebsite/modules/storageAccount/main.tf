resource "azurerm_resource_group" "storage_account_resource_group" {
  name     = "rg-${var.project_name}-${var.environment}-storage"
  location = var.location
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "sa${var.project_name}${var.environment}"
  resource_group_name      = azurerm_resource_group.storage_account_resource_group.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = var.environment
  }
}

resource "azurerm_storage_container" "example" {
  name                  = "website"
  storage_account_name = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}

