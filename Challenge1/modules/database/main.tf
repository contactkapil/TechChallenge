#Generate Random password for SQL server
resource "random_password" "password" {
  length                = 16
  special               = true
  override_special = "_%@"
}

#Create SQL Server after random password generation
resource "azurerm_sql_server" "sqlserver" {
  name                             = var.db_server_name
  resource_group_name     = var.resource_group_name
  location                          = var.region
  version                          = var.db_version
  administrator_login         = "12.0"
  administrator_login_password = random_password.password.result

  tags = {
    BillingContact = var.billing_contact
	AppOwner     = var.application_owner 
	    
  }

depends_on          = [random_password.password]
 azu
}

#Create General Purpose elastic pool after sucessful SQL server creation
resource "azurerm_mssql_elasticpool" "sqlpool" {
 
  name                 = var.elastic_pool_name
  resource_group_name = var.resource_group_name
  location               = var.region
  server_name       = azurerm_sql_server.sqlserver.name
  license_type        = "LicenseIncluded"
  max_size_gb       = 1536

  sku {
    name     = var.sku_name
    tier        = var.epool_tier
    family    = var.epool_family
    capacity = var.epool_capacity
  }
  
  per_database_settings {
    min_capacity = var.epool_min_capacity
    max_capacity = var.epool_max_capacity
  }
  depends_on          = [azurerm_sql_server.sqlsrvr]
}

#Create SQL database under sql server and add it to elastic pool
resource "azurerm_mssql_database" "sbldb" {
  name                  = var.db_name
  server_id            = azurerm_sql_server.sqlsrvr.id
  elastic_pool_id    = azurerm_mssql_elasticpool.sqlpool.id
  #max_size_gb    = 1024

  tags = {
       BillingContact = var.billing_contact
	   AppOwner = var.application_owner    
  }

depends_on          = [azurerm_mssql_elasticpool.sqlpool]
}

#Add SQL server to subnet of virtual network
resource "azurerm_sql_virtual_network_rule" "sqlvnetrule" {
  name                         = "sql-vnet-rule"
  resource_group_name = var.resource_group_name
  server_name              = azurerm_sql_server.sqlserver.name
  subnet_id                   = var.dbsubnet.id
  depends_on               = [azurerm_sql_database.sbldb]
}

#Call a submodule to add password set for SQL server to secrte under key vault
module "keyvaluesec" {
  source                       = ".,/keyvault"
  key_vault_name         = var.key_vault_name
  key_vault_rg_name     = var.key_vault_rg_name
  password_value          = random_password.password.result
  rg_name                    = var.resource_group_name
  server                       = azurerm_sql_server.sqlserver.name
  
  
 }