output "docker_registry_url" {
    value = azurerm_container_registry.container_registry.login_server
}