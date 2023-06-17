variable "resouce_group_name {
  description = "Resource group name"
}

variable "location" {
  description = "resource group location"
  
}

variable "vvnetcidr" {
  description = "Application gateway subnet prefix"
 
}

variable "gatewaycidr" {
  description = "Application gateway layer subnet address prefix"
  
}

variable "computesubnetcidr" {
  description = "Business /Compute layer subnet address prefix"
  
}

variable "dbsubnetcidr" {
  description = "Database  layer subnet address prefix"
  
}

variable "webubnetcidr" {
  description = "web  layer subnet address prefix"
  
}

variable "bastionsubnetcidr" {
  description = "bastion  layer subnet address prefix"
  
}

variable "db_versionr" {
  description = "Database Version"
  
}

variable "admin_login_id" {
  description = "DB Admin login id"
  
}

variable "elastic_pool_name" {
  description = "DB elastic pool name"
  
}

variable "db_name" {
  description = "DB name"
  
}

variable "db_server_name" {
  description = "DB server name"
  
}

variable "key_vault_rg_name" {
  description = "Key valut RG name where password is stored"
  
}

variable "key_vault_name" {
  description = "Key Valurt Name"
  
}

variable "compute_host_name" {
  description = "Key Valurt Name"
  
}

variable "compute_username" {
  description = "Compute system username"
  
}

variable "compute_image_publisher" {
  description = "Image publisher"
  
}

variable "compute_image_offer" {
  description = "Compute System Image offer"
  
}

variable "compute_image_version" {
  description = "Compute system image version"
  
}

variable "private key path" {
  description = "Private Key Path"
  
}

variable "public_key_path" {
  description = "Public Key Path"
  
}

variable "web_host_name" {
  description = "Web system machine name"
  
}

variable "web_username" {
  description = "web system username"
  
}

variable "web_image_publisher" {
  description = "Image publisher"
  
}

variable "web_image_offer" {
  description = "web System Image offer"
  
}

variable "web_image_version" {
  description = "web system image version"
  
}

variable "bastion_hostname" {
  description = "bastion host name"
  
}

variable "application_gateway_name" {
  description = "application_gateway_name"
  
}


variable "sku_name" {
  description = "sku name"
  type        = "string"
}

variable "epool_tier" {
  description = "elastic pool tier"
  type        = "string"
}

variable "epool_family" {
  description = "elastic pool family"
  type        = "string"
}

variable "epool_capacity" {
  description = "elastic pool capacity"
  type        = "string"
}

variable "epool_min_capacity" {
  description = "elastic pool minimum capacity "
  
}

variable "epool_ma_capacity" {
  description = "elastic pool maimum capacity "
  
}







