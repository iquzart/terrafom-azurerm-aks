# Azure Kubernetes Serveice
Terraform module to create Azure Kubernetes Serveice

# Usage
```
# Create Resource Group for the project.
resource "azurerm_resource_group" "rg" {
        name = var.resource_group_name
        location = var.location
        tags = var.tags
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

```

# Variables
```
variable "log_analytics_workspace_id" {
  description = "The Log Analytics Workspace Id."
}

variable "cluster_name" {
  description = "The prefix for the resources created in the specified Azure Resource Group."
}

variable "environment" {
  description = "The cluster environment"
}

variable "resource_group_name" {
  description = "The name of the Resource Group in which the Virtual Network"
}

variable "location" {
  description = "The Azure Region in which to create the Virtual Network"
}

variable "tags" {
  default     = {}
  description = "Any tags that should be present on the Virtual Network resources"
  type        = map(string)
}

variable "aad_group_ids" {
  description = "Name of the Azure AD group for cluster-admin access"
  type        = list(string)
}


variable "admin_username" {
  description = "The username of the local administrator to be created on the Kubernetes cluster"
}

variable "admin_public_ssh_key" {
  description = "The SSH key to be used for the username defined in the `admin_username` variable."
}

variable "kubernetes_version" {
  description = "Version of Kubernetes to install"
}


variable "agent_pool_profile" {
  description = "An agent_pool_profile block"
  type        = any
}



variable "default_node_pool_availability_zones" {
  description = "The default_node_pools AZs"
  type        = list(string)
  default     = null
}

variable "default_node_pool_node_taints" {
  description = "The default_node_pools node taints"
  type        = list(string)
  default     = null
}

variable "default_node_pool" {
  description = "An default_node_pool block"
  type = object({
    name                = string
    vm_size             = string
    enable_auto_scaling = string
    os_disk_size_gb     = string
    type                = string
    min_count           = string
    max_count           = string
  })
}
variable "network_profile" {
  description = "Variables defining the AKS network profile config"
  type = object({
    network_plugin     = string
    network_policy     = string
    dns_service_ip     = string
    docker_bridge_cidr = string
    pod_cidr           = string
    service_cidr       = string
  })
}

variable "vnet_subnet_id" {
  description = "Resource id of the Virtual Network subnet"
  type        = string
}

variable "acr_id" {
  description = "ACR Id"
  type        = string
}

variable  "oms_agent" {
  description = "Enabled azure monitor - True or False"
  default     = "false"
  type        = string
}

```

# License
MIT
