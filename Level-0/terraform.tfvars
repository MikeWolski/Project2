# Name for the environment
environment                              = "dev"

# Parameter for Creating Azure Resources
region                                   = "eastus"
resource_group_name                      = "team4-primary"
# Parameter for Create Virtual network and Subnets
vnet_name                                = ["team4-primary","team4-secondary"]
vnet_address                             = ["10.50.0.0/16","10.60.0.0/16"]
subnet_names                             = ["Web","Business","DB"]
subnet_er                                = ["GatewaySubnet"]
subnet_management                        = ["management"]
subnet_er_range                          = ["10.50.3.0/24"]
subnet_management_range                  = ["10.50.4.0/24"]
subnet_range                             = ["10.50.0.0/24","10.50.1.0/24","10.50.2.0/24"]

# Parameter for Create Network Security Groups
nsg_names                                = ["Web","Business","DB"]
nsg_tier1_rules                          = ["Allow_Port80_Inbound","Allow_Port443_Inbound","Allow_Port3389_Inbound","Deny_Virtualnetwork_Inbound"]
nsg_tier2_rules                          = ["Deny_Virtualnetwork_Inbound","Allow_Azuremonitor_Outbound","Deny_Internet_Outbound"]
nsg_tier3_rules                          = ["Deny_Virtualnetwork_Inbound","Allow_Azuremonitor_Outbound","Deny_Internet_Outbound"]

# Parameter for Create Route Table
rt_names                                 = ["Web","Business","DB","gateway","management"]

# Parameter for Azure Resources Tags
tagvalue                           =  {

      environment                  = "Development"
}  

