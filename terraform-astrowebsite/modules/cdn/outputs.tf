output "cdn_endpoint_uri" {
  value = azurerm_cdn_endpoint.cdn_endpoint.fqdn
}

output "cdn_endpoint_id" {
  value = azurerm_cdn_endpoint.cdn_endpoint.id
}