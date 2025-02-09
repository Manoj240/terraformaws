resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

output "name" {
  value = azurerm_resource_group.rg.name
}

output "location" {
  value = azurerm_resource_group.rg.location
}
