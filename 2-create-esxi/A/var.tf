
variable "vsphere_server" {  description = "vCenter FQDN/IP "}
variable "vsphere_user" {  description = "vSphere username"}
variable "vsphere_password" {  description = "vSphere password"}
variable "host_to_installon" {  description = "vSphere password"}
variable "vsphere_datacenter" {  description = "vSphere datacenter"}
variable "vsphere_cluster" {  description = "vSphere cluster"}
variable "vsphere_datastore" {  description = "Datastore where VMs will be deployed."}
variable "vsphere_folder" {  description = "vSphere folder to store VMs"}

variable "workload_network" {  description = "Porgroup to which the virtual machine will be connected."}
variable "iscsi_network1" {  description = "Porgroup to which the virtual machine will be connected."}
variable "vmotion_network" {  description = "Porgroup to which the virtual machine will be connected."}
variable "mgt_network" {  description = "Porgroup to which the virtual machine management will be connected."}

variable "guest_vcpu" {  description = "Guest VM vCPU amount"}
variable "guest_memory" {  description = "Guest VM Memory size"}
variable "guest_user" {  description = "Username for guest VM."}
variable "guest_password" {  description = "Password for guest user."}
variable "guest_disk0_size" {  description = "Size of first disk to be added."}
variable "guest_dns" {  description = "DNS server for the guest."}
variable "guest_ntp" {  description = "NTP server for the guest." }
variable "guest_domain" {  description = "Domain for the guest." }
variable "guest_start_ip" {  description = "Starting IP address for the guest vmk0 interface"  }
variable "guest_start_ip1" {  description = "Starting IP address for the guest vmk1 interface" }
variable "guest_start_ip2" {  description = "Starting IP address for the guest vmk1 interface" }
# variable "guest_start_ip2" {  description = "Starting IP address for the guest vmk2 interface"}
variable "guest_netmask" {  description = "Netmask for the guest vmk0 interface"   }
variable "guest_netmask1" {  description = "Netmask for the guest vmk1 interface"}
variable "guest_netmask2" {  description = "Netmask for the guest vmk1 interface"}
# variable "guest_netmask2" {  description = "Netmask for the guest vmk2 interface"}
variable "guest_gateway" {  description = "Gateway for the guest vmk0 interface" }


# variable "template" {
# default = {
#   #the type is a map of lists take note of the brackets []=list {}=map=key/value pairs
#   #to access the values: var.variablename.key[index] eg. var.template.octet[0] give you 101
#   #name = contains the template names that exists on vcente, octet is the last octet of the ip addresses it will have
  
#   "name" = [ #put the names of the templates you have in vcenter under Packer_vms
#   "1template-esxi001", 
#   "1template-esxi002",
#   "1template-esxi003", 
#   "1template-esxi004",
#   "1template-esxi005"
  
#   ]
#   "octet"=[  #put the last octet of the esxi here
#     101,
#     102,
#     103,
#     104,
#     105
#     ]
#   }
# }
variable "template" {
default = {
  #the type is a map of lists take note of the brackets []=list {}=map=key/value pairs
  #to access the values: var.variablename.key[index] eg. var.template.octet[0] give you 101
  #name = contains the template names that exists on vcente, octet is the last octet of the ip addresses it will have
  
  "name" = [ #put the names of the templates you have in vcenter under Packer_vms
  "7template-esxi-7.0.u3d001" 
  
  ]
  "octet"=[  #put the last octet of the esxi here, do not use 108 and 109 as the parent uses them
    11
    ]
  }
}



