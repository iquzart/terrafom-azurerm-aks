# Resource Group 
output "rg_name" {
  value = azurerm_resource_group.rg.name
}

output "rg_location" {
  value = azurerm_resource_group.rg.location
}

# ACR module
output "acr_id" {
    description = "The Container Registry ID."
    value = module.acr.id
}

output "acr_login_server" {
    description = "The URL that can be used to log into the container registry."
    value = module.acr.login_server
}

output "acr_admin_username" {
    description = "The Username associated with the Container Registry Admin account - if the admin account is enabled"
    value = module.acr.admin_username
}

output "acr_admin_password" {
    description = "The Password associated with the Container Registry Admin account - if the admin account is enabled."
    sensitive = true
    value = module.acr.admin_password
}

# vNet module
output "vnet_name" {
  description = "vNet Name"
  value = module.network.vnet_name
}

output "vnet_id" {
  description = "vNet id"
  value = module.network.vnet_id
}

output "subnet_name" {
  description = "Subnet Name"
  value = module.network.subnet_name
}

output "subnet_id" {
  description = "Subnet id"
  value = module.network.subnet_id
}

# Kubernetes Cluster outputs

output "host" {
  description = "The Kubernetes cluster server host."
  value       = module.kubernetes.host
}

output "client_key" {
  description = "Base64 encoded private key used by clients to authenticate to the Kubernetes cluster."
  value       = module.kubernetes.client_key
}

output "client_certificate" {
  description = "Base64 encoded public certificate used by clients to authenticate to the Kubernetes cluster."
  value       = module.kubernetes.client_certificate
}

output "cluster_ca_certificate" {
  description = "Base64 encoded public CA certificate used as the root of trust for the Kubernetes cluster."
  value       = module.kubernetes.cluster_ca_certificate
}

output "username" {
  description = "A username used to authenticate to the Kubernetes cluster."
  value       = module.kubernetes.username
}

output "password" {
  description = "A password or token used to authenticate to the Kubernetes cluster."
  value       = module.kubernetes.password
}

output "node_resource_group" {
  description = "The auto-generated Resource Group which contains the resources for this Managed Kubernetes Cluster."
  value       = module.kubernetes.node_resource_group
}

output "location" {
  description = "The location where the Managed Kubernetes Cluster was created."
  value       = module.kubernetes.location
}

output "kube_config_raw" {
  description = "Raw Kubernetes config to be used by kubectl and other compatible tools."
  value       = module.kubernetes.kube_config_raw
}


