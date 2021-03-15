variable "application" {
    type = string
    description = "App name"
}

variable "location" {
    type = string
    description = "Location of resources"
    default = "eastus"
}

variable "admin_username" {
    type = string
    description = "admin username"
}

variable "admin_pwd" {
    type = string
    description = "admin pwd"
    sensitive = true
}

variable "vm_size" {
    type = string
    description = "Size of VM"
    default = "Standard_B1S"
}

variable "vnet_address_space" {
    type = list(any)
    description = "Addr space for VNET"
    default = ["10.1.0.0/16"]
}

variable "snet_address_space" {
    type = list(any)
    description = "Addr space for Subnet"
    default = ["10.0.1.0/24"]  
}


variable "storage_account_type" {
    type = map
    description = "Disk type premium in Primary location and Standard in secondary location"
    default = {
        westus = "Premium_LRS"
        eastus = "Standard_LRS"
    }
}

variable "os" {
    description = "OS image to deploy"
    type = object({
        publisher = string
        offer = string
        sku = string
        version = string
    })
}





