#Generate Random password for windows web server
resource "random_password" "password" {
  length               = 12
  special              = true
  override_special = "_%@"
}

resource "azurerm_network_interface" "computenic" {
 count                 = 2
 name                = "${var.compute_hostname}_nic_{count.index}"
 location             = var.resource_group
 resource_group_name = var.location

 ip_configuration {
   name                          = "computeConfiguration"
   subnet_id                    = var.compute_subnet_id
   private_ip_address_allocation = "dynamic"
 }
 depends_on          = [random_password.password]
}

resource "azurerm_network_interface_security_group_association" "compute" {
  network_interface_id      = azurerm_network_interface.computenic.id
  network_security_group_id = azurerm_network_security_group.compute_sg.id
  depends_on          = [azurerm_network_interface.computenic]
}

resource "azurerm_managed_disk" "compute" {
 count                = 2
 name                = "datadisk_${var.compute_hostname}_${count.index}"
 location             = var.location
 resource_group_name  = var.resource_group
 storage_account_type = "Standard_LRS"
 create_option        = "Empty"
 disk_size_gb         = "1023"
}

resource "azurerm_availability_set" "avset" {
 name                         = "${var.compute_hostname}"
 location                      = var.location
 resource_group_name  = var.resource_group
 platform_fault_domain_count  = 2
 platform_update_domain_count = 2
 managed                      = true
 depends_on                  = [azurerm_network_interface_security_group_association.compute]
}

resource "azurerm_linux_virtual_machine" "computevm" {
 depends_on            = [azurerm_availability_set.avset]
 count                     = 2
 name                     = "${var.compute_hostname}-{count.index}"
 location                 = var.location
 availability_set_id   = azurerm_availability_set.avset.id
 resource_group_name   = var.resource_group
 network_interface_ids = [element(azurerm_network_interface.computenic.*.id, count.index)]
 vm_size               = "var.vm_size"
 delete_data_disks_on_termination = true


 connection {
        type                 = "ssh"
        #bastion_host        = "${azurerm_public_ip.bastion_pip.fqdn}"
		#bastion_host        =  var.bastion_pip_fqdn
        #bastion_user        = "${var.username}"
        #bastion_private_key = "${file(var.private_key_path)}"
        host                   = "${element(azurerm_network_interface.computenic.*.private_ip_address, count.index)}"
        user                  = "${var.username}"
        private_key       = "${file(var.private_key_path)}"
    }
	 #private_key         = "${file(var.private_key_path)}"

    storage_image_reference {
        publisher   = "${var.compute_image_publisher}"
        offer         = "${var.compute_image_offer}"
        sku           = "${var.compute_image_sku}"
        version     = "${var.compute_image_version}"
    }

    storage_os_disk {
        name              = "${var.hostname}-osdisk"
        managed_disk_type = "Standard_LRS"
        caching           = "ReadWrite"
        create_option     = "FromImage"
    }

    os_profile {
        admin_username = "${var.compute_username}"
        admin_password = "${var.password}"
    }

    os_profile_linux_config {
        disable_password_authentication = true
        ssh_keys {
            path     = "/home/${var.username}/.ssh/authorized_keys"
            key_data = "${file(var.public_key_path)}"
        }
    }


#Here we can use remote-exec to install required software at the time of installation.
    provisioner "remote-exec" {
        inline = ["sudo apt-get update && sudo apt install python3.8"]
    }
  }  
	
  #Call a submodule to add password set for linux web layer machine to secrte under key vault
 module "keyvaluesec" {
  source                       = "./modules/keyvault"
  key_vault_name         = var.key_vault_name
  key_vault_rg_name    = var.key_vault_rg_name
  password_value          = random_password.password.result
  rg_name                    = var.resource_group_name
  server                       =   azurerm_linux_virtual_machine.computevm.name
  depends_on               = [azurerm_linux_virtual_machine.computevm]
  
  
 }