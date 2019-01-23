data "azurerm_resource_group" "buildagents" {
  name = "${var.buildagents_resource_group_name}"
}

data "azurerm_public_ip" "pip" {
  name = "${var.buildagents_pip}"
  resource_group_name = "${data.azurerm_resource_group.buildagents.name}"
}

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

resource "azurerm_network_security_rule" "Allow_Inbound_Buildagents_RDP" {
  name = "Allow-Inbound-Buildagents-RDP"

  priority = "100"
  direction = "Inbound"

  access = "allow"
  protocol = "TCP"

  source_port_range = "*"
  destination_port_range = "3389"
  source_address_prefix = "${data.azurerm_public_ip.pip.ip_address}"
  destination_address_prefix = "*"

  resource_group_name = "${data.azurerm_resource_group.group.name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}

resource "azurerm_network_security_rule" "Allow_Inbound_Buildagents_WinRM_HTTP" {
  name = "Allow-Inbound-Buildagents-WinRM-HTTP"

  priority = "110"
  direction = "Inbound"

  access = "allow"
  protocol = "TCP"

  source_port_range = "*"
  destination_port_range = "5985"
  source_address_prefix = "${data.azurerm_public_ip.pip.ip_address}"
  destination_address_prefix = "*"

  resource_group_name = "${data.azurerm_resource_group.group.name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}

resource "azurerm_network_security_rule" "Allow_Inbound_Buildagents_WinRM_HTTPS" {
  name = "Allow-Inbound-Buildagents-WinRM-HTTPS"

  priority = "120"
  direction = "Inbound"

  access = "allow"
  protocol = "TCP"

  source_port_range = "*"
  destination_port_range = "5986"
  source_address_prefix = "${data.azurerm_public_ip.pip.ip_address}"
  destination_address_prefix = "*"

  resource_group_name = "${data.azurerm_resource_group.group.name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_connection" {
  subnet_id = "${azurerm_subnet.subnet.id}"
  network_security_group_id = "${azurerm_network_security_group.nsg.id}"
}

