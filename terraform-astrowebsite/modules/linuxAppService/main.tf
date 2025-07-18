resource "azurerm_service_plan" "app_service_plan" {
    location = var.location
    name = "asp-${var.project_name}-${var.environment}"
    os_type = "Linux"
    resource_group_name = var.web_app_resource_group_name
    sku_name = "B1"
}

resource "azurerm_linux_web_app" "linux_web_app" {
    location = var.location
    name = "app-${var.project_name}-${var.environment}"
    resource_group_name = var.web_app_resource_group_name
    service_plan_id = azurerm_service_plan.app_service_plan.id
    
    identity {
      type = "SystemAssigned"
    }

    site_config {
      container_registry_use_managed_identity = true
      application_stack {
        docker_registry_url = "https://${var.docker_registry_url}"
        docker_image_name = "astrowebsite:latest"
      }
    }

    app_settings = {
        "APPINSIGHTS_INSTRUMENTATIONKEY" = var.APPINSIGHTS_INSTRUMENTATIONKEY
        "APPLICATIONINSIGHTS_CONNECTION_STRING" = var.APPLICATIONINSIGHTS_CONNECTION_STRING
        "ApplicationInsightsAgent_EXTENSION_VERSION" = "~3"         # ~3 for linux apps - enabled app insights
    }
}
