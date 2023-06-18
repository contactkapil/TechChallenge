#Creating public IP for application gateway
resource "azurerm_public_ip" "pip" {
    name                             = "{var.app_gateway_name}-pip"
    location                          = var.location
    resource_group_name     = var.resource_group
    public_ip_address_allocation = "Dynamic"
}

#Creating application gateway with configuration like front end ip configuration,backend pool,settings,listeners , routing rules etc 

resource "azurerm_application_gateway" "network" {
    name                       = "${var.app_gateway_name}-apgw"
    location                   = var.location
    resource_group_name = var.resource_group 
    sku {
        name             = "Standard_Small"
        tier                = "Standard"
        capacity         = 2
      }
    gateway_ip_configuration {
        name           = "${var.app_gateway_name}-gwip-cfg"
        subnet_id      = "${var.gateway_subnet_id}"
      }
    frontend_port {
        name         = "${var.app_gateway_name}-feport"
        port           = 80
    }
    frontend_ip_configuration {
        name                      = "${var.app_gateway_name}-feip"  
        public_ip_address_id = "${azurerm_public_ip.pip.id}"
    }

    backend_address_pool {
        name = "${var.app_gateway_name}-beap"
        #ip_address_list = ["${element(azurerm_network_interface.nic.*.private_ip_address, count.index)}"] 
		ip_address_list = [var.web_nic_privateip]
    }
    backend_http_settings {
        name                           = "${var.app_gateway_name}-be-htst"
        cookie_based_affinity   = "Disabled"
        port                            = 80
        protocol                      = "Http"
        request_timeout          = 1
    }
    http_listener {
        name                                              = "${var.app_gateway_name}-httplstn"
        frontend_ip_configuration_name        = "${var.app_gateway_name}-feip"
        frontend_port_name                         = "${var.app_gateway_name}-feport"
        protocol                                           = "Http"
    }
    request_routing_rule {
        name                                    = "${var.app_gateway_name}-rqrt"
        rule_type                              = "Basic"
        http_listener_name                 = "${var.app_gateway_name}-httplstn"
        backend_address_pool_name  = "${var.app_gateway_name}-beap"
        backend_http_settings_name  = "${var.app_gateway_name}-be-htst"
    }
}