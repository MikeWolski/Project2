#To get subnet id primary
data "azurerm_subnet" "subnet_id_primary" {
    name                       = "subnet-dev-business"
    virtual_network_name       = "vnet-dev-team4-primary"
    resource_group_name        = "rg-dev-team4-primary"
}

#To get subnet id secondary
data "azurerm_subnet" "subnet_id_secondary" {
    name                       = "subnet-dev-business"
    virtual_network_name       = "vnet-dev-team4-secondary"
    resource_group_name        = "rg-dev-team4-secondary"
}

#This is for the primary
resource "azurerm_linux_virtual_machine_scale_set" "scalesetbus" {
  name                = "team4-business-scale-set"
  resource_group_name = "rg-dev-team4-primary"
  location            = "eastus"
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
      subnet_id = data.azurerm_subnet.subnet_id_primary.id
    }
  }

}


#This is for the secondary
resource "azurerm_linux_virtual_machine_scale_set" "scalesetbus1" {
  name                = "team4-business-scale-set-secondary"
  resource_group_name = "rg-dev-team4-secondary"
  location            = "eastus"
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
      subnet_id = data.azurerm_subnet.subnet_id_secondary.id
    }
  }

}