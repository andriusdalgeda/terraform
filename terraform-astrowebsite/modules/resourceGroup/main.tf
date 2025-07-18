resource "azurerm_resource_group" "webapp_resource_group" {
  location = var.location
  name     = "rg-${var.project_name}-${var.environment}"
}