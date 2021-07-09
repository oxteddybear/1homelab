
variable "vsphere_server" {
  description = "vCenter FQDN/IP "
}

variable "vsphere_user" {
  description = "vSphere username"
}

variable "vsphere_password" {
  description = "vSphere password"
}

variable "vsphere_datacenter" {
  description = "vSphere datacenter"
}

variable "compute_cluster" {
  description = "Compute cluster name"
}

# Indicate all hosts to be added to vCenter. FQDN or IP 

variable "all_hosts" {
  default =["192.168.8.101","192.168.8.102"]
}

# Indicate hosts in MGMT cluster. FQDN or IP
# variable "host_names_comp" {
# default = {
#   "192.168.8.101" = 1
#   "192.168.8.102" = 2
#   }
# }

variable "addhost" {
  default = {
   name = [
              "192.168.8.101",
              "192.168.8.102"
    ]
  }
}


# Indicate Distributed Port Group names and their respective VLAN IDs. 

variable "pg1" {
  default = {
   "pg-vdsmgt-mgt" = 0
  }
}
variable "pg2" {
  default = {
   "dpg-vdsdata-" = 4096
  }
}

variable "mgt_vmnic" {
    default = ["vmnic1"]
}
variable "data_vmnic" {
    default = ["vmnic4"]
}

variable "esxi_user" {
  description = "esxi root user"
}

variable "esxi_password" {
  description = "esxi root password"
}
variable "vds1_name" {
  description = "VDS Name"
}
variable "vds1_mtu" {
  description = "VDS MTU"
}

variable "vd2_name" {
  description = "VDS Name"
}
variable "vds2_mtu" {
  description = "VDS MTU"
}

variable "vlan_range_min" {
  description = "VLAN Starting Range"
}
variable "vlan_range_max" {
  description = "VLAN Ending Range"
}
