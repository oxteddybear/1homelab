
variable "vsphere_server"     {  description = "Standalone --not the parent--- vCenter FQDN/IP " }
variable "vsphere_user"       {  description = "vSphere username" }
variable "vsphere_password"   {  description = "vSphere password" }
variable "vsphere_datacenter" {  description = "vSphere datacenter" }
variable "esxi_user"          {  description = "esxi root user"}
variable "esxi_password"      {  description = "esxi root password"}
#variable "vds2_name"          {  description = "VDS Name"}
#variable "vds2_mtu"           {  description = "VDS MTU"}
#variable "vds3_name"          {  description = "VDS Name"}
#variable "vds3_mtu"           {  description = "VDS MTU"}

variable "addhost" { ### compute hosts
  default = {
   name = [
      "10.168.254.81",
      "10.168.254.82",
	  "10.168.254.83",
	  "10.168.254.84",
	  "10.168.254.85",
	  "10.168.254.86"
    ]
  }
}

