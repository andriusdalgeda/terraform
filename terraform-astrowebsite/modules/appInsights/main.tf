resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
    location = var.location
    name = "log-${var.project_name}-${var.environment}"
    resource_group_name = var.web_app_resource_group_name
}

resource "azurerm_application_insights" "application_insights" {
    application_type = "web"
    location = var.location
    name = "appi-${var.project_name}-${var.environment}"
    resource_group_name = var.web_app_resource_group_name
    disable_ip_masking = true
    retention_in_days = 30
    daily_data_cap_in_gb = 1
    workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id
}