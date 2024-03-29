provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "cloud-labs-dev"
    storage_account_name = "tfstatestorage0"
    container_name       = "tfstate"
    key                  = "dev.dns.terraform.tfstate"
  }
}

resource "azurerm_dns_zone" "example" {
  name                = "spoved.app.com"  
  resource_group_name = "cloud-labs-dev"
}