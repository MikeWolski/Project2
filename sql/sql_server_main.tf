data "azurerm_resource_group" "rg1" {
  name = var.rg1
}
data "azurerm_virtual_network" "vnet-dev-team4-primary" {
  name                = var.primary_vnet
  resource_group_name = var.rg1
}
data "azurerm_virtual_network" "vnet-dev-team4-secondary" {
  name                = var.secondary_vnet
  resource_group_name = var.rg2
}

#
resource "azurerm_subnet" "primary-sql-subnet-team4" {
  name                 = "primary-sql-subnet-team4"
  resource_group_name  = var.rg1
  virtual_network_name = var.primary_vnet
  address_prefixes     = ["10.50.10.0/24"]
  service_endpoints    = ["Microsoft.Sql"]
}

resource "azurerm_subnet" "secondary-sql-subnet-team4" {
  name                 = "secondary-sql-subnet-team4"
  resource_group_name  = var.rg2
  virtual_network_name = var.secondary_vnet
  address_prefixes     = ["10.60.10.0/24"]
  service_endpoints    = ["Microsoft.Sql"]
}

resource "azurerm_sql_server" "sql-primary-team4" {
  name                         = "sql-primary-team4"
  resource_group_name          = var.rg1
  location                     = var.eastus
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "Pa55w.rd1234"
}

resource "azurerm_sql_server" "sql-secondary-team4" {
  name                         = "sql-secondary-team4"
  resource_group_name          = var.rg2
  location                     = var.centralus
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "Pa55w.rd1234"
}

resource "azurerm_sql_database" "primary-db-team4" {
  name                = "primary-db-team4"
  resource_group_name = var.rg1
  location            = var.eastus
  server_name         = azurerm_sql_server.sql-primary-team4.name
}

resource "azurerm_sql_failover_group" "replication-team4" {
  name                = "replication-team4"
  resource_group_name = var.rg1
  server_name         = azurerm_sql_server.sql-primary-team4.name
  databases           = [azurerm_sql_database.primary-db-team4.id]
  partner_servers {
    id = azurerm_sql_server.sql-secondary-team4.id
  }

  read_write_endpoint_failover_policy {
    mode          = "Automatic"
    grace_minutes = 60
  }
}

resource "azurerm_sql_virtual_network_rule" "sqlvnetrule-primary-team4" {
  name                = "sql-vnet-rule-primary"
  resource_group_name = var.rg1
  server_name         = azurerm_sql_server.sql-primary-team4.name
  subnet_id           = azurerm_subnet.primary-sql-subnet-team4.id
}

resource "azurerm_sql_virtual_network_rule" "sqlvnetrule-secondary-team4" {
  name                = "sql-vnet-rule-secondary"
  resource_group_name = var.rg2
  server_name         = azurerm_sql_server.sql-secondary-team4.name
  subnet_id           = azurerm_subnet.secondary-sql-subnet-team4.id
}