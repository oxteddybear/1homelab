provider "vsphere" {
  user           = "administrator@vsphere.local"
  password       = "VMware1!"
  vsphere_server = "192.168.254.133"
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "dc1"
}

data "vsphere_datastore" "datastore" {
  name          = "iscsi108"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = "NSXT-EDGECLUSTER"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_host" "host" {
  name          = "192.168.254.108"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
