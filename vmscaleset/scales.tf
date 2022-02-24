resource "azurerm_resource_group" "team4primary" {
  name     = "rg-dev-team4-primary-test"
  location = "eastus"
}

resource "azurerm_virtual_network" "vnetprimary" {
  name                = "vnet-dev-team4-primary-test"
  resource_group_name = azurerm_resource_group.team4primary.name
  location            = azurerm_resource_group.team4primary.location
  address_space       = ["10.30.0.0/16"]
}

resource "azurerm_subnet" "businesssubnet" {
  name                 = "subnet-dev-business-test"
  resource_group_name  = azurerm_resource_group.team4primary.name
  virtual_network_name = azurerm_virtual_network.vnetprimary.name
  address_prefixes     = ["10.30.1.0/24"]
}

resource "azurerm_linux_virtual_machine_scale_set" "scalesetbus" {
  name                = "team4-business-scale-set"
  resource_group_name = azurerm_resource_group.team4primary.name
  location            = azurerm_resource_group.team4primary.location
  sku                 = "Standard_B2s"
  instances           = 3
  admin_username      = "adminuser"
  admin_password      = "Pa55w.rd1234"
  disable_password_authentication = false



  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "example"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.businesssubnet.id
    }
  }
}