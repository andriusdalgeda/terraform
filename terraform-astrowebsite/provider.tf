data "azurerm_subscription" "current" {}

# specify provider
terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "5.7.1"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
    time = {
      source = "hashicorp/time"
      version = "0.13.1"
    }
    dns = {
      source = "hashicorp/dns"
      version = "3.4.3"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = var.azure_subscription_id
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

provider "time" {
}

provider "dns" {
}