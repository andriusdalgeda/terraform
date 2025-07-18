resource "azurerm_app_service_custom_hostname_binding" "web_app_hostname_binding" {
    app_service_name = var.web_app_name
    hostname = var.website_hostname
    resource_group_name = var.resource_group_name
    
}

resource "azurerm_app_service_managed_certificate" "web_app_managed_certificate" {
    custom_hostname_binding_id = azurerm_app_service_custom_hostname_binding.web_app_hostname_binding.id   
}

resource "azurerm_app_service_certificate_binding" "web_app_certificate_binding" {
    certificate_id = azurerm_app_service_managed_certificate.web_app_managed_certificate.id
    hostname_binding_id = azurerm_app_service_custom_hostname_binding.web_app_hostname_binding.id
    ssl_state = "SniEnabled"
    
}