variable "resource_group_name" {
  type = "string"
  default = "#{resource_group_name}"
}

variable "vnet_name" {
  type = "string"
  default = "#{vnet_name}"
}

variable "vnet_address_space" {
  type = "string"
  default = "#{vnet_address_space}"
}

variable "subnet_name" {
  type = "string"
  default = "#{subnet_name}"
}

variable "subnet_address_space" {
  type = "string"
  default = "#{subnet_address_space}"
}

variable "nsg_name" {
  type = "string"
  default = "#{nsg_name}"
}

variable "buildagents_resource_group_name" {
  type = "string"
  default = "#{buildagents_resource_group_name}"
}

variable "buildagents_pip" {
  type = "string"
  default = "#{buildagents_pip}"
}