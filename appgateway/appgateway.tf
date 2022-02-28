data "azurerm_subnet" "appgateway_subnet_id_primary" {
    name                       = "subnet-dev-internetsubnet"
    virtual_network_name       = "vnet-dev-team4-primary"
    resource_group_name        = "rg-dev-team4-primary"
}

#&nbsp;since these variables are re-used - a locals block makes this more maintainable
locals {
  backend_address_pool_name      = "team4-beap"
  frontend_port_name             = "team4-feport"
  frontend_ip_configuration_name = "team4-feip"
  http_setting_name              = "team4-be-htst"
  listener_name                  = "team4-httplstn"
  request_routing_rule_name      = "team4-rqrt"
  redirect_configuration_name    = "team4-rdrcfg"
}

resource "azurerm_application_gateway" "network" {
  name                = "team4appgateway"
  resource_group_name = "rg-dev-team4-primary"
  location            = "eastus"

  sku {
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = data.azurerm_subnet.appgateway_subnet_id_primary.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name               = "frontendprivateip"
    private_ip_address = "10.50.3.10"
  }

  backend_address_pool {
    name = "appgatewaybackend"
    fqdns = ["team4webapp"]
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }
}