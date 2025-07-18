output "APPINSIGHTS_INSTRUMENTATIONKEY" {
  value = azurerm_application_insights.application_insights.instrumentation_key
}

output "APPLICATIONINSIGHTS_CONNECTION_STRING" {
    value = azurerm_application_insights.application_insights.connection_string
}

output "application_insights_id" {
  value = azurerm_application_insights.application_insights.id
}