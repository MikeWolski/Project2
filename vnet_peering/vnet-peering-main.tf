data "azurerm_virtual_network" "vnet-dev-team4-primary" {
  name                = var.primary_vnet
  resource_group_name = var.rg1
}

data "azurerm_virtual_network" "vnet-dev-team4-secondary" {
  name                = var.secondary_vnet
  resource_group_name = var.rg2
}
resource "azurerm_virtual_network_peering" "primary-to-secondary-peering" {
  count                        = 2
  name                         = "primary-to-secondary"
  resource_group_name          = var.rg1
  virtual_network_name         = var.primary_vnet
  remote_virtual_network_id    = data.azurerm_virtual_network.vnet-dev-team4-secondary.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true

  # `allow_gateway_transit` must be set to false for vnet Global Peering
  allow_gateway_transit = false
}

resource "azurerm_virtual_network_peering" "secondary-to-primary-peering" {
  count                        = 2
  name                         = "secondary-to-primary"
  resource_group_name          = var.rg2
  virtual_network_name         = var.secondary_vnet
  remote_virtual_network_id    = data.azurerm_virtual_network.vnet-dev-team4-primary.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true

  # `allow_gateway_transit` must be set to false for vnet Global Peering
  allow_gateway_transit = false
}