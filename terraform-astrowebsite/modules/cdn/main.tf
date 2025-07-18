resource "azurerm_cdn_profile" "cdn_profile" {
    location = "global"
    name = "cdn-${var.project_name}-${var.environment}"
    resource_group_name = var.resource_group_name
    sku = "Standard_Microsoft"
}

resource "azurerm_cdn_endpoint" "cdn_endpoint" {
    location = "global"
    name = "cdn-endpoint-${var.project_name}-${var.environment}"
    profile_name = azurerm_cdn_profile.cdn_profile.name
    resource_group_name = var.resource_group_name
    origin_host_header = "${var.storage_account_name}.blob.core.windows.net"
    origin {
        host_name = "${var.storage_account_name}.blob.core.windows.net"
        name = "primary-origin"
        http_port = 80
        https_port = 443
    }
    content_types_to_compress = ["application/eot", "application/font", "application/font-sfnt", "application/javascript", "application/json", "application/opentype", "application/otf", "application/pkcs7-mime", "application/truetype", "application/ttf", "application/vnd.ms-fontobject", "application/x-font-opentype", "application/x-font-truetype", "application/x-font-ttf", "application/x-httpd-cgi", "application/x-javascript", "application/x-mpegurl", "application/x-opentype", "application/x-otf", "application/x-perl", "application/x-ttf", "application/xhtml+xml", "application/xml", "application/xml+rss", "font/eot", "font/opentype", "font/otf", "font/ttf", "image/svg+xml", "text/css", "text/csv", "text/html", "text/javascript", "text/js", "text/plain", "text/richtext", "text/tab-separated-values", "text/x-component", "text/x-java-source", "text/x-script", "text/xml"]
    is_http_allowed = false
    is_https_allowed = true
    is_compression_enabled = true
    querystring_caching_behaviour = "UseQueryString"
    
}