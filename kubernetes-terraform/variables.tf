## Azure config variables ##
variable "client_id" {}

variable "client_secret" {}

variable location {
  default = "Central US"
}

## Resource group variables ##
variable resource_group_name {
  default = "nxmgmt"
}


## AKS kubernetes cluster variables ##
variable cluster_name {
  default = "mgmt-jenkins"
}

variable "agent_count" {
  default = 2
}

variable "dns_prefix" {
  default = "jenkinsdemo"
}

variable "admin_username" {
    default = "demo"
}
