
variable "vsphere_server" {
  description = "vCenter FQDN/IP "
}

variable "guest_template" {
  description = "vsphere template"
  default = "template-esxi001"
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

variable "vsphere_cluster" {
  description = "vSphere cluster"
}

variable "vsphere_datastore" {
  description = "Datastore where VMs will be deployed."
}

variable "vsphere_folder" {
  description = "vSphere folder to store VMs"
}

variable "workload_network" {
  description = "Porgroup to which the virtual machine will be connected."
}
variable "iscsi_network1" {
  description = "Porgroup to which the virtual machine will be connected."
}
variable "iscsi_network2" {
  description = "Porgroup to which the virtual machine will be connected."
}
variable "mgt_network" {
  description = "Porgroup to which the virtual machine management will be connected."
}

# Indicate VM names and value of IP address last octet . By default it will create 5 VMs 
variable "vm_names" {
default = {
  "template-esxi001" = 101
  "template-esxi002" = 102
  
  
  

}
}


variable "guest_vcpu" {
  description = "Guest VM vCPU amount"
}

variable "guest_memory" {
  description = "Guest VM Memory size"
}

variable "guest_user" {
  description = "Username for guest VM."
}
variable "guest_password" {
  description = "Password for guest user."
}

variable "guest_disk0_size" {
  description = "Size of first disk to be added."   
}

variable "guest_dns" {
  description = "DNS server for the guest."
}
variable "guest_ntp" {
  description = "NTP server for the guest."  
}
variable "guest_domain" {
  description = "Domain for the guest."  
}
variable "guest_start_ip" {
  description = "Starting IP address for the guest vmk0 interface"  
}
variable "guest_start_ip1" {
  description = "Starting IP address for the guest vmk1 interface"
}
variable "guest_start_ip2" {
  description = "Starting IP address for the guest vmk2 interface"
}
variable "guest_netmask" {
  description = "Netmask for the guest vmk0 interface"   
}
variable "guest_netmask1" {
  description = "Netmask for the guest vmk1 interface"
}
variable "guest_netmask2" {
  description = "Netmask for the guest vmk2 interface"
}
variable "guest_gateway" {
  description = "Gateway for the guest vmk0 interface"   
}
