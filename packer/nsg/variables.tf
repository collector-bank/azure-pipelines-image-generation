variable "resource_group_name" {
  type = "string"
  default = "#{resource_group_name}"
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