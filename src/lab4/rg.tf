resource "azurerm_resource_group" "webapps" {
   name         = "WEBAPPS"
   location     = "${var.loc}"
   tags         = "${var.tags}"
}