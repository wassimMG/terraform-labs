/*
variable "count" {
  default = 3
}
*/
resource "random_string" "webapprnd" {
  length  = 8
  lower   = true
  number  = true
  upper   = false
  special = false
}

resource "azurerm_app_service_plan" "free" {
    #count = "${length(var.webapplocs)}"
    count = "${var.inc}"
    name                = "plan-free-${var.webapplocs[count.index]}"
    location            = "${var.webapplocs[count.index]}"
    resource_group_name = "${azurerm_resource_group.webapps.name}"
    tags                = "${azurerm_resource_group.webapps.tags}"

    kind                = "Linux"
    sku {
        tier = "Free"
        size = "F1"
    }
}

resource "azurerm_app_service" "citadel" {
    #count = "${length(var.webapplocs)}"
    #name                = "webapp-${random_string.webapprnd.result}-${var.loc}"
    #location            = "${var.loc}"
    name                = "${format("webapp-%s-%02d-%s", random_string.webapprnd.result, count.index + 1, element(var.webapplocs, count.index))}"
    location            = "${element(var.webapplocs, count.index)}"
    resource_group_name = "${azurerm_resource_group.webapps.name}"
    tags                = "${azurerm_resource_group.webapps.tags}"

    #app_service_plan_id = "${azurerm_app_service_plan.free.id}"
    app_service_plan_id = "${element(azurerm_app_service_plan.free.*.id, count.index)}"
}