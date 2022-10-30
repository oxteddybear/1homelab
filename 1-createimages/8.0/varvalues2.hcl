vsphere_vcenter         = "192.168.254.134"
vsphere_username        = "administrator@vsphere.local"
vsphere_password        = "VMware1!"
vsphere_datacenter      = "lab"
vsphere_cluster8         = "c8"
vsphere_cluster9         = "c9"
parent_host             = "192.168.254.109"
parent_host108             = "192.168.254.108"
vsphere_datastore       = "d0"
vsphere_template_folder = "Packer_VMs"
vnic_network            = "VM Network"
vm_name1                = "template-esxi-8.0-001"
vm_name2                = "template-esxi-8.0-002"
vm_name3                = "template-esxi-8.0-003"
vm_name4                = "template-esxi-8.0-004"
vm_name5                = "template-esxi-8.0-005"
vm_name6                = "template-esxi-8.0-006"

vm_hostname             = "temphostname"
vm_guestos              = "vmkernel7guest" #for esxi7 #
#vm_guestos              = "vmkernel6guest" #for esxi6
vm_cpu_size             = "16"
vm_ram_size             = "4096"
vm_disk_size            = "81920"
guest_username          = "root"
guest_password          = "VMware1!"
ssh_timeout             = "15m"
nfs_server_path         = "192.168.254.124/ks/ks.cfg"
iso_file_path           = "iso/VMware-VMvisor-Installer-8.0-20513097.x86_64.iso"


vm_disk_controller      = "pvscsi"


