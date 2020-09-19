resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.cluster_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.cluster_name
  kubernetes_version  = var.kubernetes_version

  linux_profile {
    admin_username = var.admin_username

    ssh_key {
      # remove any new lines using the replace interpolation function
      key_data = replace(var.admin_public_ssh_key, "\n", "")
    }
  }

  default_node_pool {
    name                  = var.default_node_pool.name
    vm_size               = var.default_node_pool.vm_size
    enable_auto_scaling   = var.default_node_pool.enable_auto_scaling
    #enable_node_public_ip = var.default_node_pool.enable_node_public_ip
    #max_pods              = var.default_node_pool.max_pods
    os_disk_size_gb       = var.default_node_pool.os_disk_size_gb
    type                  = var.default_node_pool.type
    min_count             = var.default_node_pool.min_count
    max_count             = var.default_node_pool.max_count
    #node_count            = var.default_node_pool.node_count
    node_taints           = var.default_node_pool_node_taints
    vnet_subnet_id        = var.vnet_subnet_id
    availability_zones    = var.default_node_pool_availability_zones
  }

  addon_profile {
    oms_agent {
      enabled                    = var.oms_agent
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }

  network_profile {
    network_plugin     = var.network_profile.network_plugin
    network_policy     = var.network_profile.network_policy
    dns_service_ip     = var.network_profile.dns_service_ip
    docker_bridge_cidr = var.network_profile.docker_bridge_cidr
    pod_cidr           = var.network_profile.pod_cidr
    service_cidr       = var.network_profile.service_cidr
  }

  identity {
    type = "SystemAssigned"
  }


  role_based_access_control {
    enabled = true

    azure_active_directory {
      managed = true
      admin_group_object_ids = var.aad_group_ids
    }
  }

  tags = var.tags
}


resource "azurerm_role_assignment" "aks" {
  scope                            = azurerm_kubernetes_cluster.aks.id
  role_definition_name             = "Monitoring Metrics Publisher"
  principal_id                     = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}


resource "azurerm_role_assignment" "aks_subnet" {
  scope                            = var.vnet_subnet_id
  role_definition_name             = "Network Contributor"
  principal_id                     = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}


resource "azurerm_role_assignment" "aks_acr" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}


