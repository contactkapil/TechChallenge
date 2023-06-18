resource "azurerm_network_security_group" "sg" {
  name                     = "bastion-nsg"
  location                  = var.azure_location
  resource_group_name      = var.azure_resource_group
  security_rule {
    name                       = "Allow-TCP-internetand gateway"
    priority                     = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "TCP-to-virtual-network"
    description                = "Allow remote protocol out from all VMs"
    priority                   = 1000
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = ["3389","22"]
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = var.web_subnet_cidr
  }
  
  security_rule {
    name                       = "TCP-to-virtual-network"
    description                = "Allow remote protocol out from all VMs"
    priority                   = 1001
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = ["3389","22"]
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = var.compute_subnet_cidr
  }


}
