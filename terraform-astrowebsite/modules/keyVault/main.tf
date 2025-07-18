data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "azurerm_key_vault" {
    location = var.location
    name = "kv-${var.project_name}-${var.environment}"
    resource_group_name = var.web_app_resource_group_name
    sku_name = "standard"
    tenant_id = data.azurerm_client_config.current.tenant_id
}