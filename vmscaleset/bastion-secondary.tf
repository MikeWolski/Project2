data "azurerm_virtual_network" "vnet-dev-team4-secondary" {
  name                = var.secondary_vnet
  resource_group_name = var.rg2
}

resource "azurerm_public_ip" "secondary-bastion-pubIP" {
  name                = "secondary-bastion-PIP-team4"
  location            = var.centralus
  resource_group_name = var.rg2
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_subnet" "bastion_subnet_secondary" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.rg2
  virtual_network_name = var.secondary_vnet
  address_prefixes     = ["10.60.5.0/24"]
}

resource "azurerm_bastion_host" "secondary-bastion" {
  name                = "secondary-bastion-team4"
  location            = var.centralus
  resource_group_name = var.rg2

  ip_configuration {
    name                 = "pubip-secondary-bastion-team4"
    subnet_id            = azurerm_subnet.bastion_subnet_secondary.id
    public_ip_address_id = azurerm_public_ip.secondary-bastion-pubIP.id
  }
}