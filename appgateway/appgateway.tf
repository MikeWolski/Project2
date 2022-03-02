data "azurerm_subnet" "appgateway_subnet_id_primary" {
    name                       = "subnet-dev-internetsubnet"
    virtual_network_name       = "vnet-dev-team4-primary"
    resource_group_name        = "rg-dev-team4-primary"
}

resource "azurerm_subnet" "frontend" {
  name                 = "appgatewaysubnet"
  resource_group_name  = data.azurerm_subnet.appgateway_subnet_id_primary.resource_group_name
  virtual_network_name = data.azurerm_subnet.appgateway_subnet_id_primary.virtual_network_name
  address_prefixes     = ["10.50.6.0/24"]
}

resource "azurerm_public_ip" "appgatepip" {
  name                = "appgatepip"
  resource_group_name = data.azurerm_subnet.appgateway_subnet_id_primary.resource_group_name
  location            = "eastus"
  allocation_method   = "Dynamic"
}

#&nbsp;since these variables are re-used - a locals block makes this more maintainable
locals {
  backend_address_pool_name      = "${data.azurerm_subnet.appgateway_subnet_id_primary.virtual_network_name}-beap"
  frontend_port_name             = "${data.azurerm_subnet.appgateway_subnet_id_primary.virtual_network_name}-feport"
  frontend_ip_configuration_name = "${data.azurerm_subnet.appgateway_subnet_id_primary.virtual_network_name}-feip"
  http_setting_name              = "${data.azurerm_subnet.appgateway_subnet_id_primary.virtual_network_name}-be-htst"
  listener_name                  = "${data.azurerm_subnet.appgateway_subnet_id_primary.virtual_network_name}-httplstn"
  request_routing_rule_name      = "${data.azurerm_subnet.appgateway_subnet_id_primary.virtual_network_name}-rqrt"
  redirect_configuration_name    = "${data.azurerm_subnet.appgateway_subnet_id_primary.virtual_network_name}-rdrcfg"
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
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.appgatepip.id
  }

  backend_address_pool {
    name  = local.backend_address_pool_name
    fqdns = ["team4webapp.azurewebsites.net"]
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
    pick_host_name_from_backend_address = true
    probe_name            = "backendprobe1"
  }

  probe {
    name                                      = "backendprobe1"
    protocol                                  = "Http"
    interval                                  = 30
    path                                      = "/"
    timeout                                   = 30
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = true
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

#Secondary
data "azurerm_subnet" "appgateway_subnet_id_secondary" {
    name                       = "subnet-dev-internetsubnet"
    virtual_network_name       = "vnet-dev-team4-secondary"
    resource_group_name        = "rg-dev-team4-secondary"
}

resource "azurerm_subnet" "frontend2" {
  name                 = "appgatewaysubnet2"
  resource_group_name  = data.azurerm_subnet.appgateway_subnet_id_secondary.resource_group_name
  virtual_network_name = data.azurerm_subnet.appgateway_subnet_id_secondary.virtual_network_name
  address_prefixes     = ["10.60.6.0/24"]
}

resource "azurerm_public_ip" "appgatepip2" {
  name                = "appgatepip2"
  resource_group_name = data.azurerm_subnet.appgateway_subnet_id_secondary.resource_group_name
  location            = "centralus"
  allocation_method   = "Dynamic"
}

#&nbsp;since these variables are re-used - a locals block makes this more maintainable
locals {
  backend_address_pool_name2      = "${data.azurerm_subnet.appgateway_subnet_id_secondary.virtual_network_name}-beap"
  frontend_port_name2             = "${data.azurerm_subnet.appgateway_subnet_id_secondary.virtual_network_name}-feport"
  frontend_ip_configuration_name2 = "${data.azurerm_subnet.appgateway_subnet_id_secondary.virtual_network_name}-feip"
  http_setting_name2              = "${data.azurerm_subnet.appgateway_subnet_id_secondary.virtual_network_name}-be-htst"
  listener_name2                  = "${data.azurerm_subnet.appgateway_subnet_id_secondary.virtual_network_name}-httplstn"
  request_routing_rule_name2      = "${data.azurerm_subnet.appgateway_subnet_id_secondary.virtual_network_name}-rqrt"
  redirect_configuration_name2    = "${data.azurerm_subnet.appgateway_subnet_id_secondary.virtual_network_name}-rdrcfg"
}

resource "azurerm_application_gateway" "network2" {
  name                = "team4appgateway2"
  resource_group_name = "rg-dev-team4-secondary"
  location            = "centralus"

  sku {
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = data.azurerm_subnet.appgateway_subnet_id_secondary.id
  }

  frontend_port {
    name = local.frontend_port_name2
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name2
    public_ip_address_id = azurerm_public_ip.appgatepip2.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name2
    fqdns = ["team4webapp2.azurewebsites.net"]
  }

  backend_http_settings {
    name                                = local.http_setting_name2
    cookie_based_affinity               = "Disabled"
    path                                = "/path1/"
    port                                = 80
    protocol                            = "Http"
    request_timeout                     = 60
    pick_host_name_from_backend_address = true
    probe_name                          = "backendprobe2"
  }

  probe {
    name                                      = "backendprobe2"
    protocol                                  = "Http"
    interval                                  = 30
    path                                      = "/"
    timeout                                   = 30
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = true
  }

  http_listener {
    name                           = local.listener_name2
    frontend_ip_configuration_name = local.frontend_ip_configuration_name2
    frontend_port_name             = local.frontend_port_name2
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name2
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name2
    backend_address_pool_name  = local.backend_address_pool_name2
    backend_http_settings_name = local.http_setting_name2
  }
}