output "nsg_name" {
  value = "${data.azurerm_network_security_group.nsg.name}"
}
