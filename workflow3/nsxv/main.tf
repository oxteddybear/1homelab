provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  allow_unverified_ssl = true
}

resource "vsphere_datacenter" "target_dc" {
  name = var.vsphere_datacenter
}

# This is Python script that will get ESXi hosts thumbprints.
# Passing username,password and list of hosts to connect as variables. 

# data "external" "get_thumbprint" {
#    program = ["python", "Esxi-connect.py"]

#   query = {
#     username = var.esxi_user
#     password = var.esxi_password
#     hosts = "${join(" ",var.all_hosts)}"
#   }
# }

#for x number of host, duplicate the below to get their thumbprint
data "vsphere_host_thumbprint" "finger0" {
  address = var.all_hosts[0]
  insecure = true
}

data "vsphere_host_thumbprint" "finger1" {
  address = var.all_hosts[1]
  insecure = true
}

locals {
  fingerprint= [
    data.vsphere_host_thumbprint.finger0.id,
    data.vsphere_host_thumbprint.finger1.id
  ]

}

resource "vsphere_compute_cluster" "c1" {
  name            = var.compute_cluster
  datacenter_id   = vsphere_datacenter.target_dc.moid
  depends_on = [vsphere_datacenter.target_dc,]

}

resource "vsphere_host" "hostmember" {
  count = length(var.addhost)
  hostname = var.addhost.name[count.index]
  username = var.esxi_user
  password = var.esxi_password
  thumbprint = local.fingerprint[count.index]
  cluster = vsphere_compute_cluster.c1.id
  depends_on = [vsphere_compute_cluster.c1]
}


#############################1st vds
#create mgt vds
resource "vsphere_distributed_virtual_switch" "vds1" {
  name          = var.vds1_name
  datacenter_id = vsphere_datacenter.target_dc.moid
  max_mtu = var.vds1_mtu
  depends_on = [vsphere_host.hostmember]
  uplinks         = ["uplink1", "uplink2"]
  
  dynamic "host" {
    for_each = vsphere_host.hostmember
    content {
      host_system_id = vsphere_host.hostmember.id
      devices        = var.mgt_vmnic
    }
  }
 
 
  #  host {
  #   host_system_id = vsphere_host.h1["vesxi102.home.lab"].id
  #   devices        = var.mgt_vmnic
  # }

}

# Creating distributed port groups

resource "vsphere_distributed_port_group" "pg1" {
  for_each = var.pg1
  name = each.key
  distributed_virtual_switch_uuid = vsphere_distributed_virtual_switch.vds1.id
  vlan_id = each.value
}

#############################2nd vds
#create data vds
# resource "vsphere_distributed_virtual_switch" "vds2" {
#   name          = var.vds1_name
#   datacenter_id = vsphere_datacenter.target_dc.moid
#   max_mtu = var.vds2_mtu
#   depends_on = [vsphere_host.hostmember]
#   uplinks         = ["uplink1", "uplink2"]
  
#   dynamic "host" {
#     for_each = var.addhost
#     content {
#       host_system_id = vsphere_host.hostmember[each.value].id
#       devices        = var.mgt_vmnic
#     }
#   }
 
#   #  host {
#   #   host_system_id = vsphere_host.h1["vesxi102.home.lab"].id
#   #   devices        = var.mgt_vmnic
#   # }

# }
# #create pg on second vds
# resource "vsphere_distributed_port_group" "pg2" {
#   name                            = "var.pg2"
#   distributed_virtual_switch_uuid = vsphere_distributed_virtual_switch.vds2.id

#   vlan_range {
#     min_vlan = var.vlan_range_min
#     max_vlan = var.vlan_range_max
#   }
# }
