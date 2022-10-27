vsphere_vcenter         = "192.168.254.134"
vsphere_username        = "administrator@vsphere.local"
vsphere_password        = "VMware1!"
vsphere_datacenter      = "lab"
vsphere_cluster         = "c1"
parent_host             = "192.168.254.109"
parent_host108             = "192.168.254.108"
vsphere_datastore       = "d0"
vsphere_template_folder = "Packer_VMs"
vnic_network            = "VM Network"
vm_name1                = "7template-esxi-7.0.u3g001"
vm_name2                = "7template-esxi-7.0.u3g002"
vm_name3                = "7template-esxi-7.0.u3g003"
vm_name4                = "7template-esxi-7.0.u3g004"
vm_name5                = "7template-esxi-7.0.u3g005"
vm_name6                = "7template-esxi-7.0.u3g006"
vm_name7                = "7template-esxi-7.0.u3g007"
vm_hostname             = "temphostname"
#vm_guestos              = "vmkernel7guest" #for esxi7 #
vm_guestos              = "vmkernel6guest" #for esxi6
vm_cpu_size             = "16"
vm_ram_size             = "4096"
vm_disk_size            = "8192"
guest_username          = "root"
guest_password          = "VMware1!"
ssh_timeout             = "15m"
nfs_server_path         = "192.168.254.124/ks/ks.cfg"
iso_file_path           = "iso/VMware-VMvisor-Installer-7.0u3g-17325551.x86_64.iso"


vm_disk_controller      = "pvscsi"


