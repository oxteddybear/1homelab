provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "target_dc" {
  name = var.vsphere_datacenter
}

data "vsphere_host" "hostmember" {
  
  datacenter_id = data.vsphere_datacenter.target_dc.id
  
}


resource "vsphere_distributed_virtual_switch" "overlay" {
  name          = "vspherezones-vds-overlay"
  datacenter_id = data.vsphere_datacenter.target_dc.id
  max_mtu       = 9000
  uplinks       = ["uplink1"]
  dynamic "host" {
    for_each = data.vsphere_host.hostmember
    content {
      host_system_id = host.value.id
      devices        = ["vmnic6"]
    }
  }

}


