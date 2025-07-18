resource "azurerm_cdn_endpoint_custom_domain" "cnd_custom_domain" {
    cdn_endpoint_id = var.cdn_endpoint_id
    host_name = var.cdn_hostname
    name = "custom-domain"
    
    cdn_managed_https {
      certificate_type = "Dedicated"
      protocol_type = "ServerNameIndication"
      tls_version = "TLS12"
    }
}
