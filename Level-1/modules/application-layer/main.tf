# Module to Create Public IP Address for VM
module "public_ip_vm" {
  source                                  = "../public-ip"
  public_ip_enable                        = "${var.public_ip_enable}"
  public_ip_names                         = ["${var.vm_public_ip_name}"]
  allocation                              = "${var.public_ip_allocation_method}"
  region                                  = "${var.region}"
  resource_group_name                     = "${var.resource_group_name}"
  environment                             = "${var.environment}"
  sku_type                                = "${var.sku_type}"
  tagvalue                                = "${var.tagvalue}"
}


# Module to create NIC
module "network_interface" {
  source                                  = "../network-interface"
  nic_enable                              = "${var.nic_enable}"
  resource_group_name                     = "${var.resource_group_name}"
  region                                  = "${var.region}"
  subnet_names                            = "${lower("subnet-${var.environment}-${var.subnet_names[0]}")}"
  vnet_name                               = "${var.vnet_name}"
  nic_name                                = "${var.nic_name}"
  ip_allocation_method                    = "${var.nic_ip_allocation_method}"
  nic_public_ip_address_id                = "${module.public_ip_vm.public_ip_address_id[0]}"
  nic_type                                = "${var.nic_type}" 
  ip_config_name                          = "${var.nic_ip_config_name}"
  environment                             = "${var.environment}"
  tagvalue                                = "${var.tagvalue}"
}

