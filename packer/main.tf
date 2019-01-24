module "vnet" {
  source = "../vnet"
  resource_group_name = "${var.resource_group_name}"
  vnet_name = "${var.vnet_name}"
  vnet_address_space = "${var.vnet_address_space}"
  subnet_name = "${var.subnet_name}"
  subnet_address_space = "${var.subnet_address_space}"
  nsg_name = "${var.nsg_name}"
}

module "nsg" {
  source = "../nsg"
  resource_group_name = "${var.resource_group_name}"
  nsg_name = "${module.vnet.nsg_name}"
  buildagents_resource_group_name = "${var.buildagents_resource_group_name}"
  buildagents_pip = "${var.buildagents_pip}"
}

module "subnet_nsg_connection" {
  source = "../subnet-nsg-connection"
  resource_group_name = "${var.resource_group_name}"
  vnet_name = "${module.vnet.vnet_name}"
  subnet_name = "${module.vnet.subnet_name}"
  nsg_name = "${module.vnet.nsg_name}"
}
