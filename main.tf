#Terraform
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.46.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "rg-terraformstate"
    storage_account_name = "terrastatestorage218855"
    container_name = "terraformdemo"
    key = "var.terraform.tfstate"
  }
}

#Azure Provider
provider "azurerm" {
  features {
  }
}

# Create a Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "${var.application}-rg"
  location = var.location
  tags = {
    "site" = "prod"
    "cost" = "low"
  }
}

# Create a VNET
resource "azurerm_virtual_network" "main" {
  name                = "${var.application}-${var.location}-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = var.vnet_address_space
}


# Create a Subnet
resource "azurerm_subnet" "internal" {
  name                 = "${var.application}-${var.location}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.snet_address_space
}

# Create a NIC
resource "azurerm_network_interface" "nic" {
  name                = "${var.application}-nic"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  ip_configuration {
    name                          = "${var.application}-ip"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create a VM
resource "azurerm_windows_virtual_machine" "vm" {
  name                  = "${var.application}-vm"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  network_interface_ids = [azurerm_network_interface.nic.id]
  size               = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_pwd

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.os.publisher
    offer     = var.os.offer
    sku       = var.os.sku
    version   = var.os.version
  }

}
