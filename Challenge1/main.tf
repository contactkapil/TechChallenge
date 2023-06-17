provider "azurerm" {
  features {}
}

module "resourcegroup" {
  source          = "./modules/resourcegroup"
  name           = var.resouce_group_name
  location        = var.location
}

module "network" {
  source                    = "./modules/network"
  location                  = module.resourcegroup.location_name
  resource_group       = module.resourcegroup.resource_group_name
  vnetcidr                  = var.vnetcidr
  gatewaycidr            = var.gatewaysubnetcidr
  webcidr                  = var.websubnetcidr
  computesubnetcidr  = var.computesubnetcidr
  dbsubnetcidr           = var.dbsubnetcidr
  bastionsubnetcidr    = var.bastionsubnetcidr
  module_depends_on =["${module.resourcegroup.resource_group_name}"] 
  
}

module "database" {
  source                     = "./modules/database"
  region                      = module.resourcegroup.location_name
  resource_group        = module.resourcegroup.resource_group_name 
  db_version               = var.db_version
  admin_login_id         = var.admin_login_id
  elastic_pool_name    = var.elastic_pool_name
  db_name                 = var.db_name
  db_server_name      = var.db_server_name
  key_vault_rg_name  = var.key_vault_rg_name
  key_vault_name       = var.key_vault_name
  dbsubnet_id             = module.network.dbsubnet_id
  module_depends_on = ["${module.network.dbsubnet_id}", "${module.resourcegroup.resource_group_name}"] 
  
}

module "compute" {
  source                             = "./modules/compute"
  location                           = module.resourcegroup.location_name
  resource_group               = module.resourcegroup.resource_group_name
  compute_subnet_id          = module.network.computesubnet_id
  web_subnet_cidr              = var.websubnetcidr
  compute_hostname          = var.compute_host_name
  web_username                = var.compute_username
  compute_image_publisher   = var.compute_image_publisher
  compute_image_offer      = var.compute_image_offer
  compute_image_sku        = var.compute_image_sku
  compute_image_version   = var.compute_image_version
  private_key_path             = var.private_key_path
  public_key_path              = var.public_key_path
  key_vault_rg_name         = var.key_vault_rg_name
  key_vault_name              = var.key_vault_name
  bastion_subnet_cidr         = var.bastionsubnetcidr
  module_depends_on       = ["${module.network.computesubnet_id}", "${module.resourcegroup.resource_group_name}"] 
}



module "web" {
  source                            = "./modules/web"
  location                          = module.resourcegroup.location_name
  resource_group               = module.resourcegroup.resource_group_name
  web_subnet_id                = module.network.websubnet_id
  gateway_subnet_cidr       = var.gatewaysubnetcidrcidr
  web_hostname               = var.web_host_name
  web_username               = var.web_username
  web_image_publisher      = var.web_os_password
  web_image_offer            = var.web_image_offer
  web_image_sku              = var.web_image_sku
  web_image_version        = var.web_image_version
  key_vault_rg_name        = var.key_vault_rg_name
  key_vault_name            = var.key_vault_name
  bastion_subnet_cidr        = var.bastionsubnetcidr
  module_depends_on       = ["${module.module.network.websubnet_id}", "${module.resourcegroup.resource_group_name}"] 
}


module "bastion" {
  source                         = "./modules/bastionhost"
  location                       = module.resourcegroup.location_name
  resource_group           = module.resourcegroup.resource_group_name
  bastion_subnet_id        = module.network.bastion_subnet_id
  bastion_hostname        = var.bastion_hostname
  web_subnet_cidr          = var.websubnetcidrcidr
  compute_subnet_cidr   = var.computesubnetcidrcidr
  module_depends_on       = ["${ module.network.bastion_subnet_idsubnet_id}", "${module.resourcegroup.resource_group_name}"] 
  
}



module "appgateway" {
  source                       = "./modules/appgateway"
  app_gateway_name   = var.application_gateway_name
  location                     = module.resourcegroup.location_name
  resource_group         = module.resourcegroup.resource_group_name
  gateway_subnet_id    = module.network.gatewaysubnet_id
  web_nic_privateip     = module.web.web_nic_privateip
  module_depends_on  = ["${ module.network.gatewaysubnet_id}", "${module.resourcegroup.resource_group_name}","${ module.web.web_nic_privateip}"] 
  
  
}