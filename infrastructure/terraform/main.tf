terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "resource_group_name"
    storage_account_name = "client_id"
    container_name       = "container_name"
    key                  = "prod.terraform.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  #   skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}

# # Define variables
# variable "resource_group_name" {
#     type = string
# }

# variable "location" {
#     type = string
# }

# variable "aks_cluster_name" {
#     type = string
# }

# variable "aks_node_count" {
#     type = number
# }

# variable "aks_node_vm_size" {
#     type = string
# }

# variable "client_id" {
#     type = string
# }

# variable "client_secret" {
#     type = string
# }

# # Create resource group
# resource "azurerm_resource_group" "rg" {
#     name     = var.resource_group_name
#     location = var.location
# }

# # Create subnet
# resource "azurerm_subnet" "subnet" {
#     name                 = "aks-subnet"
#     resource_group_name  = azurerm_resource_group.rg.name
#     virtual_network_name = azurerm_virtual_network.vnet.name
#     address_prefixes     = ["10.0.1.0/24"]
# }

# # Create virtual network
# resource "azurerm_virtual_network" "vnet" {
#     name                = "aks-vnet"
#     address_space       = ["10.0.0.0/16"]
#     location            = azurerm_resource_group.rg.location
#     resource_group_name = azurerm_resource_group.rg.name
# }

# # Create network security group
# resource "azurerm_network_security_group" "nsg" {
#     name                = "aks-nsg"
#     location            = azurerm_resource_group.rg.location
#     resource_group_name = azurerm_resource_group.rg.name

#     security_rule {
#         name                       = "allow_ssh"
#         priority                   = 100
#         direction                  = "Inbound"
#         access                     = "Allow"
#         protocol                   = "Tcp"
#         source_port_range          = "*"
#         destination_port_range     = "22"
#         source_address_prefix      = "*"
#         destination_address_prefix = "*"
#     }
# }

# # Associate NSG with subnet
# resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
#     subnet_id                 = azurerm_subnet.subnet.id
#     network_security_group_id = azurerm_network_security_group.nsg.id
# }

# # Create AKS cluster
# resource "azurerm_kubernetes_cluster" "aks" {
#     name                = var.aks_cluster_name
#     location            = azurerm_resource_group.rg.location
#     resource_group_name = azurerm_resource_group.rg.name
#     dns_prefix          = var.aks_cluster_name

#     default_node_pool {
#         name       = "default"
#         node_count = var.aks_node_count
#         vm_size    = var.aks_node_vm_size
#     }

#     service_principal {
#         client_id     = var.client_id
#         client_secret = var.client_secret
#     }

#     tags = {
#         Environment = "dev"
#     }
# }
