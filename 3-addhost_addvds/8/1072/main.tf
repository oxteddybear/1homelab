provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "target_dc" {
  name = var.vsphere_datacenter
}

######update this fingerprint block for as many 
data "vsphere_host_thumbprint" "finger0" { #prod host
 # address = "192.168.253.85"
  address = var.addhost.name[0]
  insecure = true
}

data "vsphere_host_thumbprint" "finger1" { #prod host
 # address = "192.168.253.86"
  address = var.addhost.name[1]
  insecure = true
}



resource "vsphere_compute_cluster" "c1" {
#data "vsphere_compute_cluster" "c1" {
  name            = var.compute_cluster
  #datacenter_id   = vsphere_datacenter.target_dc.moid
  datacenter_id   = data.vsphere_datacenter.target_dc.id
  drs_enabled          = true
  drs_automation_level = "fullyAutomated"
  ha_enabled = true
}


locals {
  fingerprint = [
    data.vsphere_host_thumbprint.finger0.id,
    data.vsphere_host_thumbprint.finger1.id
    
  ]
}



resource "vsphere_host" "hostmember" {
  count = length(var.addhost.name)
  hostname = var.addhost.name[count.index]
  username = var.esxi_user
  password = var.esxi_password
  thumbprint = local.fingerprint[count.index]
  cluster = vsphere_compute_cluster.c1.id
}



#create backup vds , add hosts in hostmember and hostmember1 into respective cluster c1 and c2
resource "vsphere_distributed_virtual_switch" "vds2" {
  name          = "rack3-vds-data"
  #datacenter_id = vsphere_datacenter.target_dc.moid
  datacenter_id = data.vsphere_datacenter.target_dc.id
  max_mtu       = 9000
  uplinks       = ["uplink1"]
  #version		= "8.0.0"
  dynamic "host" {
    for_each = vsphere_host.hostmember
    content {
      host_system_id = host.value.id
      devices        = ["vmnic3"]
    }
  }

}



resource "vsphere_distributed_virtual_switch" "vds3" {
  name          = "rack3-vds-velero"
  #datacenter_id = vsphere_datacenter.target_dc.moid
  datacenter_id = data.vsphere_datacenter.target_dc.id
  max_mtu       = 1500
  uplinks       = ["uplink1"]
  #version		= "8.0.0"
  dynamic "host" {
    for_each = vsphere_host.hostmember
    content {
      host_system_id = host.value.id 
      devices        = ["vmnic4"]
    }
  }

}


resource "vsphere_distributed_port_group" "pgbackup" {
  name     = "dpg-rack3-velero-vlan456"
  distributed_virtual_switch_uuid = vsphere_distributed_virtual_switch.vds3.id

  vlan_id = 456
}
