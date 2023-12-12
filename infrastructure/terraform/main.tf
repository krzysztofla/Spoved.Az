variable "client_id" {
}
variable "client_secret" {
}
variable "tenant_id" {
}
variable "subscription_id" {
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
  backend "azurerm" {
    client_id            = var.client_id
    client_secret        = var.client_secret
    tenant_id            = var.tenant_id
    subscription_id      = var.subscription_id
    resource_group_name  = "cloud-labs-dev"
    storage_account_name = "tfstatestorage0"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}