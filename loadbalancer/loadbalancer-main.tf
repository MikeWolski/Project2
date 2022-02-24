data "azurerm_subnet" "subnet_id_primary_business" {
    name                       = "subnet-dev-business"
    virtual_network_name       = "vnet-dev-team4-primary"
    resource_group_name        = "rg-dev-team4-primary"
}

resource "azurerm_lb" "load_balancer_primary_business" {
  name                = "primary-business-load-balancer-team4"
  location            = "eastus"
  resource_group_name = "rg-dev-team4-primary"
  sku = "Basic"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    availability_zone = "No-Zone"
    subnet_id = data.azurerm_subnet.subnet_id_primary_business.id
    #gateway_load_balancer_frontend_ip_configuration_id = scalesetbus.frontend_ip

  }
}