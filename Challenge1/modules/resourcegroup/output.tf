output "resource_group_name" {
    value = azurerm_resource_group.automation3tier.name
    description = "Name of the resource group."
}

output "location_name" {
    value = azurerm_resource_group.automation3tier.location
    description = "Location  of the resource group"
}