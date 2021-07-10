provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server
  allow_unverified_ssl = true
}

resource "vsphere_datacenter" "target_dc" {
  name = var.vsphere_datacenter
}

######update this fingerprint block for as many 
data "vsphere_host_thumbprint" "finger0" { #compute host
  address = var.addhost.name[0]
  insecure = true
}

data "vsphere_host_thumbprint" "finger1" { #compute host
  address = var.addhost.name[1]
  insecure = true
}

data "vsphere_host_thumbprint" "finger2" { #edge host
  address = var.addhost1.name[0]
  insecure = true
}


resource "vsphere_compute_cluster" "c1" {
  name            = var.compute_cluster
  datacenter_id   = vsphere_datacenter.target_dc.moid
}

resource "vsphere_compute_cluster" "c2" {
  name            = var.edge_cluster
  datacenter_id   = vsphere_datacenter.target_dc.moid
}

locals {
  fingerprint = [
    data.vsphere_host_thumbprint.finger0.id,
    data.vsphere_host_thumbprint.finger1.id
  ]
    fingerprint1 = [
    data.vsphere_host_thumbprint.finger2.id
    
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

resource "vsphere_host" "hostmember1" {
  count = length(var.addhost1.name)
  hostname = var.addhost1.name[count.index]
  username = var.esxi_user
  password = var.esxi_password
  thumbprint = local.fingerprint1[count.index]
  cluster = vsphere_compute_cluster.c2.id
}


#create mgt vds 
resource "vsphere_distributed_virtual_switch" "vds1" {
  name          = var.vds1_name
  datacenter_id = vsphere_datacenter.target_dc.moid
  max_mtu       = var.vds1_mtu
  uplinks        = ["uplink1", "uplink2"]
  
  dynamic "host" {
    for_each = vsphere_host.hostmember
    content {
      host_system_id = host.value.id #here host.value.id = <dynamic "host">."value" <==tis is a keyword to get the value id.<attribute> you can view the attribute in the state
      devices        = var.mgt_vmnic
    }
  }

  dynamic "host" {
    for_each = vsphere_host.hostmember1
    content {
      host_system_id = host.value.id #here host.value.id = <dynamic "host">."value" <==tis is a keyword to get the value id.<attribute> you can view the attribute in the state
      devices        = var.mgt_vmnic
    }
  }
}

#create data vds
resource "vsphere_distributed_virtual_switch" "vds2" {
  name          = var.vds2_name
  datacenter_id = vsphere_datacenter.target_dc.moid
  max_mtu       = var.vds2_mtu
  uplinks       = ["uplink1", "uplink2"]
  
  dynamic "host" {
    for_each = vsphere_host.hostmember
    content {
      host_system_id = host.value.id #here host.value.id = <dynamic "host">."value" <==tis is a keyword to get the value id.<attribute> you can view the attribute in the state
      devices        = var.data_vmnic
    }
  }

  dynamic "host" {
    for_each = vsphere_host.hostmember1
    content {
      host_system_id = host.value.id #here host.value.id = <dynamic "host">."value" <==tis is a keyword to get the value id.<attribute> you can view the attribute in the state
      devices        = var.data_vmnic
    }
  }
}

# Distributed port groups for access mgt network

resource "vsphere_distributed_port_group" "pg1" {
  for_each = var.pg1
  name = each.key
  distributed_virtual_switch_uuid = vsphere_distributed_virtual_switch.vds1.id
  vlan_id = each.value
}

# #create pg on second vds - here i'm hardcoding since it makes no sense to create just 1 variable for this custom trunk
resource "vsphere_distributed_port_group" "pg2" {
  name     = "dpg-vdsdata-edgeuplink1"
  distributed_virtual_switch_uuid = vsphere_distributed_virtual_switch.vds2.id

    vlan_range { #got this of the state file
        max_vlan = 4094
        min_vlan = 0
    }
}

resource "vsphere_distributed_port_group" "pg3" {
  name     = "dpg-vdsdata-edgeuplink2"
  distributed_virtual_switch_uuid = vsphere_distributed_virtual_switch.vds2.id

    vlan_range { #got this of the state file
        max_vlan = 4094
        min_vlan = 0
    }
}