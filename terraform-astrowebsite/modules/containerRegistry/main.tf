resource "azurerm_container_registry" "container_registry" {    
    location = var.location
    name = "acr${var.project_name}${var.environment}"
    resource_group_name = var.web_app_resource_group_name
    sku = "Basic"
}

resource "azurerm_role_assignment" "acrpull" {
    principal_id = var.app_service_plan_managed_id
    scope = azurerm_container_registry.container_registry.id
    role_definition_name = "AcrPull"
}