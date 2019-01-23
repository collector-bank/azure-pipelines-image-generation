data "azurerm_resource_group" "group" {
  name = "${var.resource_group_name}"
}

data "azurerm_virtual_network" "vnet" {
  name = "${var.vnet_name}"
  resource_group_name = "${data.azurerm_resource_group.group.name}"
}

data "azurerm_subnet" "subnet" {
  name = "${var.subnet_name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  resource_group_name = "${data.azurerm_resource_group.group.name}"
}

data "azurerm_network_security_group" "nsg" {
  name = "${var.nsg_name}"
  resource_group_name = "${data.azurerm_resource_group.group.name}"
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_connection" {
  subnet_id = "${azurerm_subnet.subnet.id}"
  network_security_group_id = "${azurerm_network_security_group.nsg.id}"
}

