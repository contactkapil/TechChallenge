variable "resource_group" {
  description = "Resource group"
}

variable "location" {
  description = "resource location"
  
}

variable "compute_subnet_id" {
  description = "Subnet Id of VM"
 
}

variable "gateway_subnet_cidr" {
  description = "web subnet id address prefix"
 
}

variable "bastion_subnet_cidr" {
  description = "bastion subnet address prefix"
 
}

variable "web_hostname" {
  description = "VM MachineName"
 
}


variable "web_username" {
  description = "VM UserName"
 
}



variable "web_image_publisher" {
  description = "name of the publisher of the image"
 
}

variable "web_image_offer" {
  description = "the name of the offer"
 
}

variable "web_image_sku" {
  description = "image sku to apply"
 
}

variable "web_image_version" {
  description = "version of the image to apply"
 
}





variable "key_vault_rg_name" {
  description = "key value Resource group"
 
}

variable "key_vault_name" {
  description = "Key vault name"
 
}

