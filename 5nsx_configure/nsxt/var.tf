variable "nsx_manager" { default = "192.168.254.61"}
variable "nsx_password" { default = "VMware1!VMware1!"}
variable "license_keys" { description "add license keys at the prompt"}
  
}

# variable "vsphere_server"     {  description = "Standalone --not the parent--- vCenter FQDN/IP " }
# variable "vsphere_user"       {  description = "vSphere username" }
# variable "vsphere_password"   {  description = "vSphere password" }
# variable "vsphere_datacenter" {  description = "vSphere datacenter" }
# variable "compute_cluster"    {  description = "Compute cluster name"}
# variable "edge_cluster"       {  description = "edge cluster name"}
# variable "esxi_user"          {  description = "esxi root user"}
# variable "esxi_password"      {  description = "esxi root password"}
# variable "vds1_name"          {  description = "VDS Name"}
# variable "vds1_mtu"           {  description = "VDS MTU"}
# variable "vds2_name"          {  description = "VDS Name"}
# variable "vds2_mtu"           {  description = "VDS MTU"}

# variable "addhost" { ### compute hosts
#   default = {
#    name = [
#       "192.168.8.103",
#       "192.168.8.104"
#     ]
#   }
# }

# variable "addhost1" { ### edge hosts
#   default = {
#    name = [
#       "192.168.8.105"
#     ]
#   }
# }

# variable "pg1" { # put all the portgroups for the mgtvds here: <portgroup-name> = <vlanid>
#   default = {
#    "dpg-vdsmgt-mgt" = 0
#   }
# }

# variable "mgt_vmnic"  {  default = ["vmnic1"] }
# variable "data_vmnic" {  default = ["vmnic4","vmnic5"] }

