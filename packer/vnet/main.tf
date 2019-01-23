
data "azurerm_resource_group" "group" {
  name = "${var.resource_group_name}"
}

resource "azurerm_virtual_network" "vnet" {
  name = "${var.vnet_name}"
  address_space = ["${var.vnet_address_space}"]

  resource_group_name = "${data.azurerm_resource_group.group.name}"
  location = "${data.azurerm_resource_group.group.location}"
}

resource "azurerm_subnet" "subnet" {
  name = "${var.subnet_name}"
  address_prefix = "${var.subnet_address_space}"

  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  resource_group_name = "${data.azurerm_resource_group.group.name}"
}

resource "azurerm_network_security_group" "nsg" {
  name = "${var.nsg_name}"

  resource_group_name = "${data.azurerm_resource_group.group.name}"
  location = "${data.azurerm_resource_group.group.location}"
}
