variable "resource_group" {
  description = "Resource group"
}

variable "location" {
  description = "resource location"
  
}


variable "bastion_subnet_id" {
  description = "Subnet id of bastion host"
}


variable "bastion_hostname" {
  description = "Bastion Hostname"
 
}

variable "web_subnet_cidr" {
  description = "Address prefix for web subnet"
 
}

variable "compute_subnet_cidr " {
  description = "Address prefix for compute subnet"
 
}
