data "azurerm_virtual_network" "vnet-dev-team4-primary" {
  name                = var.primary_vnet
  resource_group_name = var.rg
}

resource "azurerm_public_ip" "primary-bastion-pubIP" {
  name                = "primary-bastion-PIP-team4"
  location            = var.eastus
  resource_group_name = var.rg
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_subnet" "bastion_subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.rg
  virtual_network_name = var.primary_vnet
  address_prefixes     = ["10.50.5.0/24"]
}

resource "azurerm_bastion_host" "primary-bastion" {
  name                = "primary-bastion-team4"
  location            = var.eastus
  resource_group_name = var.rg

  ip_configuration {
    name                 = "pubip-primary-bastion-team4"
    subnet_id            = azurerm_subnet.bastion_subnet.id
    public_ip_address_id = azurerm_public_ip.primary-bastion-pubIP.id
  }
}