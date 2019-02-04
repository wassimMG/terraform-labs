variable "count" {
  default = 5
}
resource "azurerm_resource_group" "nic" {
   name     = "NIC"
   location     = "${var.loc}"
   tags         = "${var.tags}"
}


resource "azurerm_network_interface" "nic" {
  count = "${var.count}"
  name                = "mynic00${count.index + 1}"
  location            = "${azurerm_resource_group.nic.location}"
  resource_group_name = "${azurerm_resource_group.nic.name}"
  tags                = "${azurerm_resource_group.nic.tags}"

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = "${azurerm_subnet.prod.id}"
    private_ip_address_allocation = "Dynamic"
  }
}