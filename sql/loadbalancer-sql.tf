#LoadBalancer For SQL Primary -------------------------------------------------

resource "azurerm_public_ip" "sql-lb-ip-1" {
  name                = "pubIP-sql-LB-primary-team4"
  location            = var.eastus
  resource_group_name = var.rg1
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "sql-lb-1" {
  name                = "sqlLB-primary-team4"
  location            = var.eastus
  resource_group_name = var.rg1
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "frendIP-sql-primary"
    public_ip_address_id = azurerm_public_ip.sql-lb-ip-1.id
  }
}
resource "azurerm_lb_backend_address_pool" "backend-primary-sql" {
  loadbalancer_id = azurerm_lb.sql-lb-1.id
  name            = "BackEndAddressPool-sql-primary"
}
resource "azurerm_lb_backend_address_pool_address" "sql-server-1" {
  name                    = "sql-server-primary"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend-primary-sql.id
  virtual_network_id      = data.azurerm_virtual_network.vnet-dev-team4-primary.id
  ip_address              = "10.50.10.0"
}


#LoadBalancer For SQL Secondary ----------------------------------------------
resource "azurerm_public_ip" "sql-lb-ip-2" {
  name                = "pubIP-sql-LB-secondary-team4"
  location            = var.centralus
  resource_group_name = var.rg2
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "sql-lb-2" {
  name                = "sqlLB-secondary-team4"
  location            = var.centralus
  resource_group_name = var.rg2
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "frendIP-sql-secondary"
    public_ip_address_id = azurerm_public_ip.sql-lb-ip-2.id
  }
}
resource "azurerm_lb_backend_address_pool" "backend-secondary-sql" {
  loadbalancer_id = azurerm_lb.sql-lb-2.id
  name            = "BackEndAddressPool-sql-secondary"
}
resource "azurerm_lb_backend_address_pool_address" "sql-server-2" {
  name                    = "sql-server-secondary"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend-secondary-sql.id
  virtual_network_id      = data.azurerm_virtual_network.vnet-dev-team4-secondary.id
  ip_address              = "10.60.10.0"
}
