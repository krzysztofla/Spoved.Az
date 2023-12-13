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
    key                  = "dev.terraform.tfstate"
  }
}


#####-------------------------------Infra configuration-------------------------------#####

variable "aks_client_id" {
  type = string
}
variable "aks_client_secret" {
  type = string
}

resource "azurerm_resource_group" "aks" {
  name     = "cloud-labs-dev"
  location = "polandcentral"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "spoved-az-cluster"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = "spoved-dev"
  kubernetes_version  = "1.28.2"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  service_principal {
    client_id     = var.aks_client_id
    client_secret = var.aks_client_secret
  }

  network_profile {
    network_plugin = "azure"
  }
}