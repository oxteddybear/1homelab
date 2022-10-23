vsphere_vcenter         = "10.168.254.134"
vsphere_username        = "administrator@vsphere.local"
vsphere_password        = "VMware1!"
vsphere_datacenter      = "lab"
vsphere_cluster         = "c1"
parent_host             = "192.168.254.108"
vsphere_datastore       = "d0"
vsphere_template_folder = "Packer_VMs"
vnic_network            = "VM Network"
vm_name1                = "8template-esxi-8.0001"
vm_name2                = "8template-esxi-8.0002"
vm_name3                = "8template-esxi-8.0003"
vm_name4                = "8template-esxi-8.0004"
vm_name5                = "8template-esxi-8.0005"
vm_hostname             = "temphostname"
#vm_guestos              = "vmkernel7guest" #for esxi7 #
vm_guestos              = "vmkernel6guest" #for esxi6
vm_cpu_size             = "24"
vm_ram_size             = "51200"
vm_disk_size            = "81920"
guest_username          = "root"
guest_password          = "VMware1!"
ssh_timeout             = "15m"
nfs_server_path         = "192.168.254.123/ks/ks.cfg"
iso_file_path           = "iso/VMware-VMvisor-Installer-8.0-20513097.x86_64.iso"


vm_disk_controller      = "pvscsi"


