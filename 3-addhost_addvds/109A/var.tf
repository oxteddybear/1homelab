
variable "vsphere_server"     {  description = "Standalone --not the parent--- vCenter FQDN/IP " }
variable "vsphere_user"       {  description = "vSphere username" }
variable "vsphere_password"   {  description = "vSphere password" }
variable "vsphere_datacenter" {  description = "vSphere datacenter" }
variable "compute_cluster"    {  description = "Compute cluster name"}
variable "esxi_user"          {  description = "esxi root user"}
variable "esxi_password"      {  description = "esxi root password"}
variable "vds2_name"          {  description = "VDS Name"}
variable "vds2_mtu"           {  description = "VDS MTU"}
variable "vds3_name"          {  description = "VDS Name"}
variable "vds3_mtu"           {  description = "VDS MTU"}

variable "addhost" { ### compute hosts
  default = {
   name = [
      "192.168.253.1",
      "192.168.253.2"
    ]
  }
}


#variable "pg1" { # put all the portgroups for the mgtvds here: <portgroup-name> = <vlanid>
#  default = {
#   "dpg-vdsmgt-mgt" = 0
#  }
#}
#variable "pg2" { # put all the portgroups for the proddata here: <portgroup-name> = <vlanid>
#  default = {
#    "dpg-prod-ovl-edge-trunk1" = "0-4094",
#
#  }
#}

variable "mgt_vmnic"  {  default = ["vmnic1"] }
#variable "data_vmnic2" {  default = ["vmnic4","vmnic5"] }
variable "data_vmnic2" {  default = ["vmnic4"] }
variable "data_vmnic3" {  default = ["vmnic6"] }
