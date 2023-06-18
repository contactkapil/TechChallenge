resource "azurerm_network_security_group" "web_sg" {
  name                     = "web-nsg"
  location                 = var.azure_location
  resource_group_name      = var.azure_resource_group
  security_rule {
    name                       = "Allow-inbound-bastion"
	description                = "Allow traffic azure bastion"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = ["3389","22"]
    source_address_prefix      = var.bastion_subnet_cidr
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_gateway_traffic"
    description                = "Allow traffic from application gateway"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "80"
    destination_port_range     = "*"
    source_address_prefix      = var.gateway_subnet_cidr
    destination_address_prefix = "*"
  }


}

