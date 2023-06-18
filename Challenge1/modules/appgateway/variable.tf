variable "resource_group" {
  description = "Resource group"
}

variable "location" {
  description = "resource location"
  
}

variable "app_gateway_name" {
  description = "Application Gateway name to set"
  
}



variable "web_nic_privateip" {
  description = "Vnet name"
 
}

variable "var.getway_subnet_id" {
  description = "Id of subnet created for gateway"
 
}

variable "web_nic_ip_address" {
  description = "Ip address of NIC of given VM to be added in backend pool"
 
}
