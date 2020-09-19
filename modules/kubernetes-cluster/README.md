# Azure Virtual Network
Terraform module to create Virtual Network and Subnet

# Usage
```
# Create Resource Group for the project.
resource "azurerm_resource_group" "rg" {
        name = var.resource_group_name
        location = var.location
        tags = var.tags
}

# Create Network resources
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

```

# Variables
```

```

# License
MIT
