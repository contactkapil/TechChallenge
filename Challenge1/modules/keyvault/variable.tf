variable "rg_name" {
  description = "Resource group of server"
}

variable "server" {
  description = "nameof  server"
  type        = "string"
}

variable "key_vault_rg_name" {
  description = "Resource group of key vault"
  type        = "string"
}

variable "password_value" {
  description = "Password value to be set"
  type        = "string"
  
}