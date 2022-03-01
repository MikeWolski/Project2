#Create primary container registry
resource "azurerm_container_registry" "acr" {
  name                     = "team4containerregistryprimary"
  resource_group_name      = "rg-dev-team4-primary"
  location                 = "eastus"
  sku                      = "Standard"
  admin_enabled            = true
}

#Create primary app service plan
resource "azurerm_app_service_plan" "web_app_service_plan_primary" {
 name                = "webappserviceplanprimary"
 location            = "eastus"
 resource_group_name = "rg-dev-team4-primary"
 kind                = "Linux"
 reserved            = true

 sku {
   tier     = "PremiumV2"
   size     = "P2v2"
   capacity = "3"
 }
}
/*
#Create secondary container registry
resource "azurerm_container_registry" "acr1" {
  name                     = "team4containerregistrysecondary"
  resource_group_name      = "rg-dev-team4-secondary"
  location                 = "centralus"
  sku                      = "Standard"
  admin_enabled            = true
}
*/
#Create secondary app service plan
resource "azurerm_app_service_plan" "web_app_service_plan_secondary" {
 name                = "webappserviceplansecondary"
 location            = "centralus"
 resource_group_name = "rg-dev-team4-secondary"
 kind                = "Linux"
 reserved            = true

 sku {
   tier     = "PremiumV2"
   size     = "P2v2"
   capacity = "3"
 }
}