# Provider Configuration
provider "azurerm" {
  features {}

  subscription_id = var.ARM_SUBSCRIPTION_ID
  client_id       = var.ARM_CLIENT_ID
  client_secret   = var.ARM_CLIENT_SECRET
  tenant_id       = var.ARM_TENANT_ID
}

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.16.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "mkterrastate"
    storage_account_name = "mkterrastatestorage"
    container_name       = "tfstatefile"
    key                  = "terraform.tfstate"
  }
}

module "resource_group" {
  source = "./modules/resource_group"
  resource_group_name = var.resource_group_name
  location = var.location
}

module "network" {
  source              = "./modules/network"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
}

module "compute" {
  source              = "./modules/compute"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  network_interface_id = module.network.network_interface_id
}

output "public_ip" {
  value = module.compute.public_ip
}
