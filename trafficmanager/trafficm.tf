data "azurerm_application_gateway" "network" {
  name                = "team4appgateway"
  resource_group_name = "rg-dev-team4-secondary"
}

data "azurerm_application_gateway" "network2" {
  name                = "team4appgateway2"
  resource_group_name = "rg-dev-team4-secondary"
}

resource "random_id" "server" {
  keepers = {
    azi_id = 1
  }

  byte_length = 8
}

resource "azurerm_resource_group" "tmrg" {
  name     = "rg-dev-team4-trafficmanager"
  location = "West Europe"
}

resource "azurerm_traffic_manager_profile" "tmprofile" {
  name                = random_id.server.hex
  resource_group_name = azurerm_resource_group.tmrg.name

  traffic_routing_method = "Weighted"

  dns_config {
    relative_name = random_id.server.hex
    ttl           = 100
  }

  monitor_config {
    protocol                     = "http"
    port                         = 80
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 9
    tolerated_number_of_failures = 3
  }

  tags = {
    environment = "Production"
  }
}

resource "azurerm_traffic_manager_endpoint" "appgate1endpoint" {
  name                = "appgate1"
  resource_group_name = azurerm_resource_group.tmrg.name
  profile_name        = azurerm_traffic_manager_profile.tmprofile.name
  target_resource_id  = data.azurerm_application_gateway.network.id
  type                = "azureEndpoints"
  weight              = 100
}

resource "azurerm_traffic_manager_endpoint" "appgate2endpoint" {
  name                = "appgate2"
  resource_group_name = azurerm_resource_group.tmrg.name
  profile_name        = azurerm_traffic_manager_profile.tmprofile.name
  target_resource_id  = data.azurerm_application_gateway.network2.id
  type                = "azureEndpoints"
  weight              = 100
}