variable "resource_group" {
  description = "Resource group"
}

variable "location" {
  description = "resource location"
  
}

variable "vnetcidr" {
  description = "Application gateway subnet prefix"
 
}

variable "gatewaysubnetcidr" {
  description = "Application gateway layer subnet address prefix"
  
}

variable "websubnetcidr" {
  description = "web layer subnet address prefix"
  
}

variable "computesubnetcidr" {
  description = "Business /Compute layer subnet address prefix"
  
}

variable "dbsubnetcidr" {
  description = "Database  layer subnet address prefix"
  
}