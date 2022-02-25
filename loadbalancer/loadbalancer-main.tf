data "azurerm_subnet" "subnet_id_primary_business" {
  name                 = "subnet-dev-business"
  virtual_network_name = "vnet-dev-team4-primary"
  resource_group_name  = "rg-dev-team4-primary"
}
data "azurerm_virtual_network" "vnet-dev-team4-primary" {
  name                = "vnet-dev-team4-primary"
  resource_group_name = "rg-dev-team4-primary"
}

data "azurerm_virtual_machine_scale_set" "primary_scale_set" {
  name                = "team4-business-scale-set"
  resource_group_name = "rg-dev-team4-primary"
}

output "vm-scale-set-id" {
  value = data.azurerm_virtual_machine_scale_set.primary_scale_set.id
}
resource "azurerm_public_ip" "team4-pubIP-loadbalance-primary" {
  name                = "team4-pubIP-loadbalance"
  location            = "eastus"
  resource_group_name = data.azurerm_subnet.subnet_id_primary_business.resource_group_name
  allocation_method   = "Static"
}

resource "azurerm_lb" "load_balancer_primary_business" {
  name                = "primarybusinessloadbalancerteam4"
  location            = "eastus"
  resource_group_name = data.azurerm_subnet.subnet_id_primary_business.resource_group_name
  sku                 = "Basic"

  frontend_ip_configuration {
    name                 = "PublicIPAddress-primary"
    availability_zone    = "No-Zone"
    subnet_id            = data.azurerm_subnet.subnet_id_primary_business.id

  }
}

resource "azurerm_lb_backend_address_pool" "backend_address_primary" {
  loadbalancer_id = azurerm_lb.load_balancer_primary_business.id
  name            = "BackEndAddressPool-primary"
}
