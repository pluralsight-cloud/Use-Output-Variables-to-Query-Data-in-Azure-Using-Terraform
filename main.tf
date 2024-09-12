# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.1.0"
    }
  }

  required_version = ">= 0.14.9"
}

# Azure Provider configuration
provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  subscription_id = "<ADD SUBSCRIPTION ID>"
}

# Data source existing Resource Group
data azurerm_resource_group existing-rg {
  name = "<ADD YOUR RESOURCE GROUP NAME>"
}

# Create a Virtual Network
resource azurerm_virtual_network vnet {
  name                = "BatmanInc"
  address_space       = ["10.0.0.0/16"]
  resource_group_name = data.azurerm_resource_group.existing-rg.name
  location            = data.azurerm_resource_group.existing-rg.location
  tags = {
    Environment = "TheBatcave"
    Team        = "Batman"
  }
}

# Create subnet
resource azurerm_subnet subnet {
  name                 = "Robins"
  resource_group_name = data.azurerm_resource_group.existing-rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
