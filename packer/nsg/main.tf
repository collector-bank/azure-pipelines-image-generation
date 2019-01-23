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

data "azurerm_network_security_group" "nsg" {
  name = "${var.nsg_name}"

  resource_group_name = "${data.azurerm_resource_group.group.name}"
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
  network_security_group_name = "${data.data.azurerm_network_security_group.nsg.name}"
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
  network_security_group_name = "${data.azurerm_network_security_group.nsg.name}"
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
  network_security_group_name = "${data.azurerm_network_security_group.nsg.name}"
}
