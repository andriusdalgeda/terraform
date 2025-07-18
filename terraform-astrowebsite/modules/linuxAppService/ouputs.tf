output "app_service_plan_id" {
    value = azurerm_service_plan.app_service_plan.id
}

output "web_app_domain_verification_id" {
  value = azurerm_linux_web_app.linux_web_app.custom_domain_verification_id
}

output "web_app_name" {
  value = azurerm_linux_web_app.linux_web_app.name
}

output "app_service_plan_managed_id" {
  value = azurerm_linux_web_app.linux_web_app.identity[0].principal_id
}

output "web_app_default_domain" {
  value = azurerm_linux_web_app.linux_web_app.default_hostname
}


