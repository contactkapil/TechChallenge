variable "resource_group" {
  description = "Resource group"
}

variable "location" {
  description = "resource location"
  
}

variable "compute_subnet_id" {
  description = "Subnet Id of VM"
 
}

variable "web_subnet_cidr" {
  description = "web subnet id address prefix"
 
}

variable "bastion_subnet_cidr" {
  description = "web subnet id address prefix"
 
}

variable "compute_hostname" {
  description = "VM MachineName"
 
}


variable "compute_username" {
  description = "VM UserName"
 
}



variable "compute_image_publisher" {
  description = "name of the publisher of the image"
 
}

variable "compute_image_offer" {
  description = "the name of the offer"
 
}

variable "compute_image_sku" {
  description = "image sku to apply"
 
}

variable "compute_image_version" {
  description = "version of the image to apply"
 
}



variable "private_key_path" {
  description = "Private key path"
 
}

variable "public_key_path" {
  description = "Public key path"
 
}

variable "key_vault_rg_name" {
  description = "key value Resource group"
 
}

variable "key_vault_name" {
  description = "Key vault name"
 
}
