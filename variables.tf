# Resource Group Variables
variable "resource_group_name" {
  description = "Resource Group Name"
  type        = string
  default     = "RG_Iqbal_Tests"
}

variable "location" {
  description = "Resource Location"
  type        = string
  default     = "northeurope"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type    = map(string)
  default = {
    "Environment" = "Development"
    "BU" = "Information Technology"
  }
}

# ACR module variables
variable "acr_name" {
    description = "(Required) Specifies the name of the Container Registry. alpha numeric characters only"
    default = "iqbalacr01"
}

variable "acr_admin_enabled" {
    description = "(Optional) Specifies whether the admin user is enabled. Defaults to false."
    default = true
}

variable "acr_sku" {
    description = "(Optional) The SKU name of the the container registry. Possible values are Basic, Standard and Premium. Default = Basic"
    default = "Basic"
}

variable "acr_georeplication_locations" {
    description = "(Optional) A list of Azure locations where the container registry should be geo-replicated."
    default = null
}

# vNet module variables
variable "vnet_name" {
  description = "Virtual Network Name"
  type        = string
  default     = "vNet"
}

variable "vnet_cidr" {
  description = "Virtual Network CIDR"
  type        = list(string)
  default     = ["172.20.16.0/24"]
}

variable "subnet_name" {
  description = "Virtual Network - Subnet Name"
  type        = string
  default     = "Azure-Kubernetes-Cluster-01"
}

variable "subnet_cidr" {
  description = "AKS Subnet CIDR"
  type        = list(string)
  default     = ["172.20.16.0/26"]
}


# Kubernetes-Cluster Variables
variable "cluster_name" {
  description = "The prefix for the resources created in the specified Azure Resource Group."
  default = "containerplatform"
}

variable "environment" {
  description = "The cluster environment"
  default   = "production"
}

variable "admin_username" {
  default     = "ladmin"
  description = "The username of the local administrator to be created on the Kubernetes cluster"
  type        = string
}



variable "aad_group_ids" {
  description = "Name of the Azure AD group for cluster-admin access"
  type        = list(string)
  default     = ["cfe67379-a900-4a08-8435-875c07a782d8"]
}

variable  "oms_agent" {
  description = "Enabled azure monitor - True or False"
  default     = "true"
  type        = string
}

variable "log_analytics_workspace_sku" {
  description = "The SKU (pricing level) of the Log Analytics workspace. For new subscriptions the SKU should be set to PerGB2018"
  default     = "PerGB2018"
  type        = string
}

variable "log_retention_in_days" {
  description = "The retention period for the logs in days"
  default     = 30
  type        = number
}

variable "kubernetes_version" {
  description = "Version of Kubernetes to install"
  default     = "1.16.10"
  type        = string
}

variable "public_ssh_key" {
  description = "A custom ssh key to control access to the AKS cluster"
  default     = ""
  type        = string
}

variable "agent_pool_profile" {
  description = "An agent_pool_profile block, see terraform.io/docs/providers/azurerm/r/kubernetes_cluster.html#agent_pool_profile"
  type        = list(any)
  default = [{
    name            = "nodepool"
    count           = 1
    vm_size         = "Standard_B2s"
    os_type         = "Linux"
    agents_count    = 2
    os_disk_size_gb = 50
  }]
}

variable "default_node_pool" {
  description = "A default_node_pool block, see terraform.io/docs/providers/azurerm/r/kubernetes_cluster.html#default_node_pool"
  type = object({
    name                = string
    vm_size             = string
    enable_auto_scaling = string
    os_disk_size_gb     = string
    type                = string
    min_count           = string
    max_count           = string
  })
  default = {
    name                = "nodepool"
    vm_size             = "Standard_D4s_v3"
    enable_auto_scaling = true
    os_disk_size_gb     = 30
    type                = "VirtualMachineScaleSets"
    min_count           = 1
    max_count           = 3
  }
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
  default = {
    network_plugin     = "kubenet"
    network_policy     = "calico"
    dns_service_ip     = "10.247.0.10"
    docker_bridge_cidr = "10.249.0.1/16"
    pod_cidr           = "10.248.0.0/16"
    service_cidr       = "10.247.0.0/16"
  }
}

