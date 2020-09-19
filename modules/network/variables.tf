variable "resource_group_name" {
    description = "(Required) The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created."
}

variable "location" {
    description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type    = map(string)
  default = {
    "Environment" = "Development"
    "BU" = "Information Technology"
  }
}

variable "vnet_name" {
  description = "Virtual Network Name"
  type        = string
  default     = ""
}

variable "vnet_cidr" {
  description = "Virtual Network CIDR"
  type        = list(string)
  default     = [""]
}

variable "subnet_name" {
  description = "Virtual Network - Subnet Name"
  type        = string
  default     = ""
}

variable "subnet_cidr" {
  description = "AKS Subnet CIDR"
  type        = list(string)
  default     = [""]
}
