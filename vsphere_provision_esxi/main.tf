provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  allow_unverified_ssl = true
}

data "vsphere_datacenter" "target_dc" {
  name = var.vsphere_datacenter
}

data "vsphere_datastore" "target_datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.target_dc.id
}

# data "vsphere_compute_cluster" "target_cluster" {
#   name          = var.vsphere_cluster
#   datacenter_id = data.vsphere_datacenter.target_dc.id
# }

data "vsphere_network" "mgt_network" {
  name          = var.mgt_network
  datacenter_id = data.vsphere_datacenter.target_dc.id
}
data "vsphere_network" "iscsi_network1" {
  name          = var.iscsi_network1
  datacenter_id = data.vsphere_datacenter.target_dc.id
}
# data "vsphere_network" "iscsi_network2" {
#   name          = var.iscsi_network2
#   datacenter_id = data.vsphere_datacenter.target_dc.id
# }

data "vsphere_network" "workload_network" {
  name          = var.workload_network
  datacenter_id = data.vsphere_datacenter.target_dc.id
}

#query the below data sources for as many as templates as you needj
data "vsphere_virtual_machine" "template0" {
  name          = var.template.name[0]
  datacenter_id = data.vsphere_datacenter.target_dc.id
}
data "vsphere_virtual_machine" "template1" {
  name          = var.template.name[1]
  datacenter_id = data.vsphere_datacenter.target_dc.id
}
data "vsphere_virtual_machine" "template2" {
  name          = var.template.name[2]
  datacenter_id = data.vsphere_datacenter.target_dc.id
}
data "vsphere_virtual_machine" "template3" {
  name          = var.template.name[3]
  datacenter_id = data.vsphere_datacenter.target_dc.id
}

data "vsphere_virtual_machine" "template4" {
  name          = var.template.name[4]
  datacenter_id = data.vsphere_datacenter.target_dc.id
}

data "vsphere_host" "host" {
  name          = var.host_to_installon
  datacenter_id = data.vsphere_datacenter.target_dc.id
}

# increase the number of data resource queries in locals block below to match the templates you need
locals {
  uuids = [
    data.vsphere_virtual_machine.template0.id,
    data.vsphere_virtual_machine.template1.id,
    data.vsphere_virtual_machine.template2.id,
    data.vsphere_virtual_machine.template3.id,
    data.vsphere_virtual_machine.template4.id
  ]

}


resource "vsphere_virtual_machine" "vesxi" {
  count = length(var.template.name)
  name = substr(var.template.name[count.index],9,7) #take a subset of the template name as new vm name## substr(string, offset, length) eg. substr("template-esxi001",9,7) = esxi001
  datastore_id     = data.vsphere_datastore.target_datastore.id
  folder           = var.vsphere_folder
  # resource_pool_id = data.vsphere_compute_cluster.target_cluster.resource_pool_id
  resource_pool_id = data.vsphere_datacenter.target_dc.id
  host_system_id = data.vsphere_host.host.id
  num_cpus = var.guest_vcpu
  memory   = var.guest_memory
  nested_hv_enabled = "true"
  wait_for_guest_net_routable ="false"
  guest_id = "vmkernel7Guest" #i hardcoded this, although you can query this from the data resource of the template
  wait_for_guest_net_timeout = 35
  wait_for_guest_ip_timeout = 35
  scsi_type = "pvscsi"
 
  network_interface {    network_id   = data.vsphere_network.mgt_network.id       }
  network_interface {    network_id   = data.vsphere_network.mgt_network.id       }
  network_interface {    network_id   = data.vsphere_network.iscsi_network1.id    }
  # network_interface {    network_id   = data.vsphere_network.iscsi_network2.id    }
  network_interface {    network_id   = data.vsphere_network.workload_network.id  }
  network_interface {    network_id   = data.vsphere_network.workload_network.id  }
  network_interface {    network_id   = data.vsphere_network.workload_network.id  }
  network_interface {    network_id   = data.vsphere_network.workload_network.id  }
  network_interface {    network_id   = data.vsphere_network.workload_network.id  }
 
 ##to add more disks copy paste the disk block
  disk {
    label            = "disk0"
    size             = var.guest_disk0_size
    thin_provisioned = true
  }
  #figure the below out later! 
  #haha figured it out. use the locals block to index the data resouce as an map of list. ie. an array
    clone {
    template_uuid = local.uuids[count.index]
    timeout = 120     
  
  }

provisioner "remote-exec" {
    inline = ["esxcli system hostname set -H=esxi-${var.template.octet[count.index]} -d=${var.guest_domain}",
    "esxcli network ip dns server add --server=${var.guest_dns}",
    "echo server ${var.guest_ntp} > /etc/ntp.conf && /etc/init.d/ntpd start",
    "esxcli network vswitch standard add -v vSwitch1",
    "esxcli network vswitch standard uplink add --uplink-name=vmnic2 --vswitch-name=vSwitch1",
    "esxcli network vswitch standard set -m 9000 -v vSwitch1",

    # "esxcli network vswitch standard add -v vSwitch2",
    # "esxcli network vswitch standard uplink add --uplink-name=vmnic3 --vswitch-name=vSwitch2",
    # "esxcli network vswitch standard set -m 9000 -v vSwitch2",
    
    "esxcli network vswitch standard portgroup add --portgroup-name=iscsi1 --vswitch-name=vSwitch1",
    #"esxcli network vswitch standard portgroup set --portgroup-name=iscsi1 --vlan-id=0",
    "esxcli network ip interface add -p iscsi1 -i vmk1 -m 9000",

    # "esxcli network vswitch standard portgroup add --portgroup-name=iscsi2 --vswitch-name=vSwitch2",
    #"esxcli network vswitch standard portgroup set --portgroup-name=iscsi2 --vlan-id=0",
    # "esxcli network ip interface add -p iscsi2 -i vmk2 -m 9000",
    # "esxcli network ip interface tag add -i vmk2 -t VMotion",

    "esxcli network ip interface ipv4 set -i vmk0 -t static -g ${var.guest_gateway} -I ${var.guest_start_ip}${var.template.octet[count.index]} -N ${var.guest_netmask}",
    "esxcli network ip interface ipv4 set -i vmk1 -t static -I ${var.guest_start_ip1}${var.template.octet[count.index]} -N ${var.guest_netmask1}",
    # "esxcli network ip interface ipv4 set -i vmk2 -t static -I ${var.guest_start_ip2}${var.template.octet[count.index]} -N ${var.guest_netmask}",
    "esxcli iscsi software set --enabled=true",

    "esxcli iscsi networkportal add -n vmk1 -A vmhba65",
    # "esxcli iscsi networkportal add -n vmk2 -A vmhba65",
    "esxcli iscsi adapter discovery sendtarget add -a 10.10.8.176:3260 -A vmhba65",  
    "esxcli iscsi adapter discovery sendtarget add -a 10.10.9.177:3260 -A vmhba65",
    "esxcli iscsi adapter discovery rediscover -A vmhba65"
    ]
}

connection  {
      user           = var.guest_user
      password       = var.guest_password
      timeout = 15
      host  = self.guest_ip_addresses[0]
    }  

}
