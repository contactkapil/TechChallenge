variable "resource_group_name" {
  description = "Name of the resource group od db server"
  type        = "string"
}

variable "region" {
  description = "Azure region where sql server will be located"
  type        = "string"
}

variable "db_version" {
  description = "Db server version'."
  type        = "string"
  default     = "Dynamic"
}

variable "admin_login_id" {
  description = "Login Id of SQL DB"
  type        = "string"
  default     = "sqladmin"
}

variable "elastic_pool_name" {
  description = "Name of the elastic pool"
  type        = "string"
}

variable "db_name" {
  description = "Database Name"
  type        = "string"
}

variable "db_server_name" {
  description = "Database server Name"
  type        = "string"
}

variable "key_vault_rg_name" {
  description = "Resource Group of keyvalut"
  type        = "string"
}

variable "key_vault_name" {
  description = "Resource Group of keyvalut"
  type        = "string"
}

variable "dbsubnet_id" {
  description = "DB Subnet Id "
  
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