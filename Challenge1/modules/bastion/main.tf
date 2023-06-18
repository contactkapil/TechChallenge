resource "azurerm_public_ip" "bastion" {
  name                      = "bastionpip"
  location                   = var.resource_group
  resource_group_name = var.location
  allocation_method   = "Static"
  sku                        = "Standard"
}

resource "azurerm_subnet_network_security_group_association" "bastion" {
  subnet_id                         = var.bastion_subnet_id
  network_security_group_id = azurerm_network_security_group.sg.id
}

resource "azurerm_bastion_host" "bastion" {
  name                    = var.bastion_hostname
  location                 = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                   = "configuration"
    subnet_id              = var.bastion_subnet_id
    public_ip_address_id = azurerm_public_ip.bastion.id
  }
}