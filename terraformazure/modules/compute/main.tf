resource "azurerm_windows_virtual_machine" "vm" {
  name                = "vm-example"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = "Standard_B1ms"
  admin_username      = "testmanasa"
  admin_password      = "Daddy@240Daddy@240"
  network_interface_ids = [var.network_interface_id]
  computer_name       = "vm-example"

  os_disk {
    name                 = "example-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 30
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter-smalldisk"
    version   = "latest"
  }
}

output "public_ip" {
  value = azurerm_windows_virtual_machine.vm.public_ip_address
}