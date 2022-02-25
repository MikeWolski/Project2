resource "azurerm_container_registry" "acr" {
  name                     = "team4containerregistry"
  resource_group_name      = "rg-dev-team4-primary"
  location                 = "eastus"
  sku                      = "Standard"
  admin_enabled            = true
}

resource "azurerm_app_service_plan" "web_app_service_plan" {
 name                = "webappserviceplan"
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

resource "azurerm_app_service" "web_app_service_container" {
 name                    = "team4webappservicecontainer"
 location                = "eastus"
 resource_group_name     = "rg-dev-team4-primary"
 app_service_plan_id     = azurerm_app_service_plan.web_app_service_plan.id
 https_only              = true
 client_affinity_enabled = true
 app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    
    # Settings for private Container Registires  
    DOCKER_REGISTRY_SERVER_URL      = "https://${azurerm_container_registry.acr.login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = azurerm_container_registry.acr.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = azurerm_container_registry.acr.admin_password
  
  }
  # Configure Docker Image to load on start
  site_config {
    linux_fx_version = "DOCKER|mwolski22/movie_app:latest"
    always_on        = "true"
  }
  identity {
    type = "SystemAssigned"
  }
/*
 site_config {
    scm_type                  = "VSTSRM"
    http2_enabled             = true
    always_on                 = true
#    use_32_bit_worker_process = true
    linux_fx_version          = "DOCKER|mwolski22/movie_app:latest" #define the images to usecfor you application

    health_check_path         = "/health" # health check required in order that internal app service plan loadbalancer do not loadbalance on instance down
 }
*/
# identity {
#   type         = "SystemAssigned, UserAssigned"
#   identity_ids = [data.azurerm_user_assigned_identity.assigned_identity_acr_pull.id]
# }

# app_settings = local.env_variables 
}