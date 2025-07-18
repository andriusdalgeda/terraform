data "azurerm_client_config" "current" {}

# init rg
module "webapp_resource_group" {
  source = "./modules/resourceGroup"
  location = var.location
  project_name = var.project_name
  environment = var.environment
}

# app insights & law 
module "appInsights" {
  source = "./modules/appInsights"
  location = var.location
  project_name = var.project_name
  web_app_resource_group_name = module.webapp_resource_group.webapp_resource_group_name
  environment = var.environment
}

# docker container reg
module "containerRegistry" {
  source = "./modules/containerRegistry"
  project_name = var.project_name
  environment = var.environment
  location = var.location
  web_app_resource_group_name = module.webapp_resource_group.webapp_resource_group_name
  app_service_plan_managed_id = module.linuxAppService.app_service_plan_managed_id
}

# kv
module "key_vault" {
  source = "./modules/keyVault"
  location = var.location
  environment = var.environment
  project_name = var.project_name
  web_app_resource_group_name = module.webapp_resource_group.webapp_resource_group_name
}

# app service plan & web app
module "linuxAppService" {
  source = "./modules/linuxAppService"

  project_name = var.project_name

  environment = var.environment
  location = var.location
  web_app_resource_group_name = module.webapp_resource_group.webapp_resource_group_name
  APPINSIGHTS_INSTRUMENTATIONKEY = module.appInsights.APPINSIGHTS_INSTRUMENTATIONKEY
  APPLICATIONINSIGHTS_CONNECTION_STRING = module.appInsights.APPLICATIONINSIGHTS_CONNECTION_STRING
  application_insights_id = module.appInsights.application_insights_id

  docker_registry_url = module.containerRegistry.docker_registry_url

  key_vault_id = module.key_vault.key_vault_id
}

module "storage_account" {
  source = "./modules/storageAccount"
  environment = var.environment
  location = var.location
  project_name = var.project_name
}

# cdn setup plus custom domain
module "cdn" {
  source = "./modules/cdn"
  location = var.location
  project_name = var.project_name
  resource_group_name = module.webapp_resource_group.webapp_resource_group_name
  environment = var.environment
  cdn_hostname = var.cdn_hostname
  storage_account_name = module.storage_account.storage_account_name
}

# domain verification for web app & cdn
module "cloudflare" {
  source = "./modules/cloudflare"
  cdn_hostname = var.cdn_hostname
  web_app_domain_verification_id = module.linuxAppService.web_app_domain_verification_id
  website_hostname = var.website_hostname
  cdn_endpoint_uri = module.cdn.cdn_endpoint_uri
  zone_id = var.cloudflare_zone_id
  cdn_endpoint_id = module.cdn.cdn_endpoint_id
  web_app_default_domain = module.linuxAppService.web_app_default_domain

  depends_on = [
    module.cdn,
    module.linuxAppService
  ]
}

# hostname binding for web app
module "hostname_binding" {
  source = "./modules/linuxAppServiceHostnameBinding"
  resource_group_name = module.webapp_resource_group.webapp_resource_group_name
  web_app_name = module.linuxAppService.web_app_name
  website_hostname = var.website_hostname
  
  depends_on = [ 
    module.cloudflare 
  ]
}

module "cdn_custom_domain" {
  source = "./modules/cdnCustomDomain"
  cdn_endpoint_id = module.cdn.cdn_endpoint_id
  cdn_hostname = var.cdn_hostname
  depends_on = [
    module.cloudflare
  ]
}


