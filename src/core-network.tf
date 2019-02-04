resource "azurerm_resource_group" "network" {
   name     = "NETWORK"
   location     = "${var.loc}"
   tags         = "${var.tags}"
}

resource "azurerm_virtual_network" "core" {
  name                = "core"
  location            = "${azurerm_resource_group.network.location}"
  resource_group_name = "${azurerm_resource_group.network.name}"
  tags                = "${azurerm_resource_group.network.tags}"
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["1.1.1.1", "10.0.0.5"]

  subnet {
    name           = "GatewaySubnet"
    address_prefix = "10.0.0.0/24"
  }

  subnet {
    name           = "Training"
    address_prefix = "10.0.2.0/24"
  }

  subnet {
    name           = "Dev"
    address_prefix = "10.0.3.0/24"
  }


}

resource "azurerm_subnet" "prod" {
   name                 = "prod"
   resource_group_name  = "${azurerm_resource_group.network.name}"
   virtual_network_name = "${azurerm_virtual_network.core.name}"

   address_prefix       = "10.0.4.0/24"
   
}