# Azure Container Registry
Terraform module to create ACR

# Usage
```
module "acr" {
        source  = "github.com/iquzart/terraform-azurerm-acr"
        #version = "0.x.y"

        name                      = "ACR Name"
        resource_group_name       = "Resource Group Name"
        location                  = "Resource Location"
        sku                       = "ACR SKU"
        admin_enabled             = "true od false"
        georeplication_locations  = "Georeplication locations (premium SKU)"
        tags                      = "Resource Tags"
}

```

# Variables
```
variable "name" {
    description = "(Required) Specifies the name of the Container Registry. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
    description = "(Required) The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created."
}

variable "location" {
    description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "admin_enabled" {
    description = "(Optional) Specifies whether the admin user is enabled. Defaults to false."
    default = true
}

variable "sku" {
    description = "(Optional) The SKU name of the the container registry. Possible values are Basic, Standard and Premium. Default = Basic"
    default = "Basic"
}

variable "tags" {
    description = "(Optional) A mapping of tags to assign to the resource."
    default = {}
}

variable "georeplication_locations" {
    description = "(Optional) A list of Azure locations where the container registry should be geo-replicated."
    default = null
}
```

# License
MIT
