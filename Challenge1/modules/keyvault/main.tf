#Create unique secrete name with db resource group ,sql server 
locals {
  #password_value = var.adminPassword
  secretkey_name  = "${var.rg_name}-${var.server}"
  
}

#Get the key vault resource group details
data "azurerm_resource_group" "keyvaultrg" {
  name = var.key_vault_rg_name
}


#Get the key vault details
data "azurerm_key_vault" "keyvault" {
  name                        = local.key_vault_name
  resource_group_name = data.azurerm_resource_group.keyvaultrg.name
}


#Create secret key to store admin password 
resource "azurerm_key_vault_secret" "keyscret" {
  name             = local.secretkey_name
  value             = var.password_value
  key_vault_id  = data.azurerm_key_vault.keyvault.id
}