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

data "vsphere_compute_cluster" "target_cluster" {
  name          = var.vsphere_cluster
  datacenter_id = data.vsphere_datacenter.target_dc.id
}

data "vsphere_network" "mgt_network" {
  name          = var.mgt_network
  datacenter_id = data.vsphere_datacenter.target_dc.id
}
data "vsphere_network" "iscsi_network1" {
  name          = var.iscsi_network1
  datacenter_id = data.vsphere_datacenter.target_dc.id
}
data "vsphere_network" "iscsi_network2" {
  name          = var.iscsi_network2
  datacenter_id = data.vsphere_datacenter.target_dc.id
}

data "vsphere_network" "workload_network" {
  name          = var.workload_network
  datacenter_id = data.vsphere_datacenter.target_dc.id
}

data "vsphere_virtual_machine" "source_template" {
  name          = var.guest_template
  datacenter_id = data.vsphere_datacenter.target_dc.id
}



resource "vsphere_virtual_machine" "vesxi" {
  for_each = var.vm_names
  name = each.key
  datastore_id     = data.vsphere_datastore.target_datastore.id
  folder           = var.vsphere_folder
  resource_pool_id = data.vsphere_compute_cluster.target_cluster.resource_pool_id
  num_cpus = var.guest_vcpu
  memory   = var.guest_memory
  nested_hv_enabled = "true"
  wait_for_guest_net_routable ="false"
  guest_id = data.vsphere_virtual_machine.source_template.guest_id
  wait_for_guest_net_timeout = 35
  wait_for_guest_ip_timeout = 35
  scsi_type = data.vsphere_virtual_machine.source_template.scsi_type


  # First interface will be in MGMT port group
  network_interface {
    network_id   = data.vsphere_network.mgt_network.id
    
  }
  
 network_interface {
    network_id   = data.vsphere_network.mgt_network.id
    
  }
  network_interface {
    network_id   = data.vsphere_network.iscsi_network1.id
    
  }
  network_interface {
    network_id   = data.vsphere_network.iscsi_network2.id
    
  }
    network_interface {
    network_id   = data.vsphere_network.workload_network.id
    
  }
  network_interface {
    network_id   = data.vsphere_network.workload_network.id
    
  }
 
 network_interface {
    network_id   = data.vsphere_network.workload_network.id
    
  }
  network_interface {
    network_id   = data.vsphere_network.workload_network.id
    
  }
 
  disk {
    label            = "disk0"
    size             = var.guest_disk0_size
    thin_provisioned = true
  }
  

  # clone {
  #   template_uuid = data.vsphere_virtual_machine.source_template.id
  #   timeout = 120     
  
  # }

provisioner "remote-exec" {
    inline = ["esxcli system hostname set -H=${each.key} -d=${var.guest_domain}",
    "esxcli network ip dns server add --server=${var.guest_dns}",
    "echo server ${var.guest_ntp} > /etc/ntp.conf && /etc/init.d/ntpd start",
    "esxcli network vswitch standard add -v vSwitch1",
    "esxcli network vswitch standard uplink add --uplink-name=vmnic2 --vswitch-name=vSwitch1",
    "esxcli network vswitch standard set -m 9000 -v vSwitch1",

    "esxcli network vswitch standard add -v vSwitch2",
    "esxcli network vswitch standard uplink add --uplink-name=vmnic3 --vswitch-name=vSwitch2",
    "esxcli network vswitch standard set -m 9000 -v vSwitch2",
    
    "esxcli network vswitch standard portgroup add --portgroup-name=iscsi1 --vswitch-name=vSwitch1",
    "esxcli network vswitch standard portgroup set --portgroup-name=iscsi1 --vlan-id=0",
    "esxcli network ip interface add -p iscsi1 -i vmk1 -m 9000",

    "esxcli network vswitch standard portgroup add --portgroup-name=iscsi2 --vswitch-name=vSwitch2",
    "esxcli network vswitch standard portgroup set --portgroup-name=iscsi2 --vlan-id=0",
    "esxcli network ip interface add -p iscsi2 -i vmk1 -m 9000",

    "esxcli network ip interface ipv4 set -i vmk0 -t static -g ${var.guest_gateway} -I ${var.guest_start_ip}${each.value} -N ${var.guest_netmask}",

    "esxcli iscsi software set --enabled=true",

    "esxcli iscsi networkportal add -n vmk1 -A vmhba65",
    "esxcli iscsi networkportal add -n vmk2 -A vmhba65",
    "esxcli iscsi adapter discovery sendtarget add -a 10.10.8.176:3260 -A vmhba65 | esxcli iscsi adapter discovery sendtarget add -a 10.10.9.177:3260 -A vmhba65",
    "esxcli iscsi adapter discovery rediscover"
    ]
}

connection  {
      user           = var.guest_user
      password       = var.guest_password
      timeout = 15
      host  = self.guest_ip_addresses[0]
    }  

   }


  
