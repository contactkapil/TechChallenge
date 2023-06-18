output "web_nic_privateip" {
  value = ["${element(azurerm_network_interface.nic.*.private_ip_address, count.index)}"] 
  description = "Get list of all NIC address"
}