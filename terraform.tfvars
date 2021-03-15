application = "tf-demo-001"
location = "westus2"
vm_size = "Standard_B1s"
admin_username = "thinkuser"
admin_pwd = "Motorola1234"
vnet_address_space = ["10.0.0.0/16"]
snet_address_space = ["10.0.0.0/24"]
os = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
}
