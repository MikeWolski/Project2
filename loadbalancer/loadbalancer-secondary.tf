data "azurerm_subnet" "secondary_subnet_business" {
  name                 = "subnet-dev-business"
  virtual_network_name = "vnet-dev-team4-secondary"
  resource_group_name  = "rg-dev-team4-secondary"
}
data "azurerm_virtual_network" "vnet-dev-team4-secondary" {
  name                = "vnet-dev-team4-secondary"
  resource_group_name = "rg-dev-team4-secondary"
}

resource "azurerm_public_ip" "team4-pubIP-loadbalance-secondary" {
  name                = "team4-pubIP-loadbalance"
  location            = var.centralus
  resource_group_name = data.azurerm_subnet.secondary_subnet_business.resource_group_name
  allocation_method   = "Static"
}

resource "azurerm_lb" "load_balancer_secondary_business" {
  name                = "secondarybusinessloadbalancerteam4"
  location            = var.centralus
  resource_group_name = data.azurerm_subnet.secondary_subnet_business.resource_group_name
  sku                 = "Basic"

  frontend_ip_configuration {
    name                 = "PublicIPAddress-secondary"
    availability_zone    = "No-Zone"
    subnet_id            = data.azurerm_subnet.secondary_subnet_business.id

  }
}

resource "azurerm_lb_backend_address_pool" "backend_address_secondary" {
  loadbalancer_id = azurerm_lb.load_balancer_secondary_business.id
  name            = "BackEndAddressPool-secondary"
}
