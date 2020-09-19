# Create Resource Group for the project.
resource "azurerm_resource_group" "rg" {
        name = var.resource_group_name
        location = var.location
        tags = var.tags
}

# Create ACR 
module "acr" {
        ##source  = "./modules/acr"
        source  = "github.com/iquzart/terraform-azurerm-acr"

        resource_group_name       = azurerm_resource_group.rg.name
        location                  = azurerm_resource_group.rg.location
        name                      = var.acr_name
        sku                       = var.acr_sku
        admin_enabled             = var.acr_admin_enabled
        georeplication_locations  = var.acr_georeplication_locations
        tags                      = var.tags
}

# Create Network
module "network" {
        source  =  "github.com/iquzart/terraform-azurerm-vnet"

        vnet_name                 = var.vnet_name
        resource_group_name       = azurerm_resource_group.rg.name
        location                  = azurerm_resource_group.rg.location
        vnet_cidr                 = var.vnet_cidr
        subnet_name               = var.subnet_name
        subnet_cidr               = var.subnet_cidr
        tags                      = var.tags        
}

# SSH key for VMSS
module "ssh-key" {
  source         = "./modules/ssh-key"
  public_ssh_key = var.public_ssh_key == "" ? "" : var.public_ssh_key
}

# Create AKS Cluster
module "kubernetes" {
  source                               = "./modules/kubernetes-cluster"
  cluster_name                         = var.cluster_name
  environment                          = var.environment
  resource_group_name                  = azurerm_resource_group.rg.name
  location                             = azurerm_resource_group.rg.location
  admin_username                       = var.admin_username
  admin_public_ssh_key                 = var.public_ssh_key == "" ? module.ssh-key.public_ssh_key : var.public_ssh_key
  kubernetes_version                   = var.kubernetes_version
  agent_pool_profile                   = var.agent_pool_profile
  default_node_pool                    = var.default_node_pool
  default_node_pool_availability_zones = var.default_node_pool_availability_zones
  default_node_pool_node_taints        = var.default_node_pool_node_taints
  network_profile                      = var.network_profile
  vnet_subnet_id                       = module.network.subnet_id
  acr_id                               = module.acr.id
  aad_group_ids                        = var.aad_group_ids
  oms_agent                            = var.oms_agent
  log_analytics_workspace_id           = module.log_analytics_workspace.id
  tags                                 = var.tags
}

# Create LA Workspace
module "log_analytics_workspace" {
  source              = "./modules/log-analytics-workspace"
  prefix              = var.cluster_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  retention_in_days   = var.log_retention_in_days
  sku                 = var.log_analytics_workspace_sku
}

# Create LA Solution
module "log_analytics_solution" {
  source                = "./modules/log-analytics-solution"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  workspace_resource_id = module.log_analytics_workspace.id
  workspace_name        = module.log_analytics_workspace.name
}
