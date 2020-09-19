output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "subnet_name" {
  value = azurerm_subnet.subnet.name
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "subnet_id" {
  value = azurerm_subnet.subnet.id
}

output "address_space" {
  value = azurerm_virtual_network.vnet.address_space
}

output "address_prefix" {
  value = azurerm_subnet.subnet.address_prefix
}
