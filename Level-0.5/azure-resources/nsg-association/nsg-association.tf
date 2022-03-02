# Resource Creation to associate nsg with subnet
resource "azurerm_subnet_network_security_group_association" "networksgassociation-web" {
    subnet_id                 = "${var.subnet_id[0]}"
    network_security_group_id = "${var.nsg_id[0]}" 
   }

# Resource Creation to associate nsg with subnet
resource "azurerm_subnet_network_security_group_association" "networksgassociation-db" {
    subnet_id                 = "${var.subnet_id[2]}"
    network_security_group_id = "${var.nsg_id[2]}" 
   }