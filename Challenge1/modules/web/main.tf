#Generate Random password for windows web server
resource "random_password" "password" {
  length           = 12
  special          = true
  override_special = "_%@"
}

resource "azurerm_network_interface" "webnic" {
 count               = 2
 name                = "acctni${count.index}"
 location            = var.resource_group
 resource_group_name = var.location

 ip_configuration {
   name                          = "webConfiguration"
   subnet_id                     = var.web_subnet_id
   private_ip_address_allocation = "dynamic"
 }
 depends_on          = [random_password.password]
}

resource "azurerm_network_interface_security_group_association" "web" {
  network_interface_id          = azurerm_network_interface.webnic.id
  network_security_group_id = azurerm_network_security_group.web_sg.id
  depends_on                      = [azurerm_network_interface.webnic]
}


resource "azurerm_availability_set" "avset" {
 name                             = "avset"
 location                          = var.location
 resource_group_name      = var.resource_group
 platform_fault_domain_count  = 2
 platform_update_domain_count = 2
 managed                        = true
 depends_on                    = [azurerm_network_interface_security_group_association.web]
}

resource "azurerm_windows_virtual_machine" "webserver" {
depends_on             = [azurerm_availability_set.avset]
 count                      = 2
 name                      = "acctvm${count.index}"
 location                   = var.location
 availability_set_id    = azurerm_availability_set.avset.id
 resource_group_name   = var.resource_group
 network_interface_ids    = [element(azurerm_network_interface.webnic.*.id, count.index)]
 vm_size                       = "var.vm_size"
 #delete_data_disks_on_termination = true


 

    storage_image_reference {
        publisher = "${var.web_image_publisher}"
        offer       = "${var.web_image_offer}"
        sku        = "${var.web_image_sku}"
        version   = "${var.web_image_version}"
    }

    storage_os_disk {
        name              = "${var.hostname}-osdisk"
        managed_disk_type = "Standard_LRS"
        caching           = "ReadWrite"
        create_option     = "FromImage"
    }

    os_profile {
        admin_username = "${var.username}"
        admin_password = random_password.password.result
    }

    

#Here we can use remote-exec to install required software at the time of installation.
    provisioner "remote-exec" {
        
    }

}
	
  #Call a submodule to add password set for windows web layer machine to secrte under key vault
 module "keyvaluesec" {
  source                         = "../keyvault"
  key_vault_name           = var.key_vault_name
  key_vault_rg_name      = var.key_vault_rg_name
  password_value           = random_password.password.result
  rg_name                     = var.resource_group_name
  server                        = azurerm_windows_virtual_machine.webserver.name
  depends_on                = [azurerm_windows_virtual_machine.webserver]
  
  
 
}