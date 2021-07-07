variable vsphere_vcenter           {  default = "" }
variable vsphere_username          {  default = "" }

variable vsphere_password          {  default = "" }
variable vsphere_datacenter        {  default = "" }
variable vsphere_cluster           {  default = "" }
variable parent_host               {  default = "" }
variable vsphere_datastore         {  default = "" }
variable vsphere_template_folder   {  default = "" }
variable vm_name1                  {  default = "" }
variable vm_name2                  {  default = "" }
variable vm_name3                  {  default = "" }
variable vm_name4                  {  default = "" }


variable vm_hostname               {  default = "" }
variable vm_guestos                {  default = "" }
variable vm_cpu_size               {  default = "" }
variable vm_ram_size               {  default = "" }
variable vm_disk_size              {  default = "" }
variable guest_username            {  default = "" }
variable guest_password            {  default = "" }
variable ssh_timeout               {  default = "" }
variable nfs_server_path           {  default = "" }

variable iso_file_path             {  default = "" }
variable vnic_network              {  default = "" }
variable vm_disk_controller        {  default = "" }
#josephyap-the attributes can be found here https://github.com/jetbrains-infra/packer-builder-vsphere. the official doc in hasicorp is crap. 

###1st source is the 1st esxi to build
source "vsphere-iso" "esxi1" {
  CPUs                 = "${var.vm_cpu_size}"
  RAM                  = "${var.vm_ram_size}"
  boot_command         = ["<enter>", "<SHIFT+O>", " ks=nfs://${var.nfs_server_path}", "<enter>", ""]
  cluster              = "${var.vsphere_cluster}"
  communicator         = "ssh"
  convert_to_template  = "true"
  datacenter           = "${var.vsphere_datacenter}"
  datastore            = "${var.vsphere_datastore}"
  folder               = "${var.vsphere_template_folder}"
  guest_os_type        = "${var.vm_guestos}"
  host                 = "${var.parent_host}"
  insecure_connection  = true
  iso_paths            = ["[${var.vsphere_datastore}] ${var.iso_file_path}"]
  disk_controller_type    = ["${var.vm_disk_controller}"]
  network_adapters {
    network      = "${var.vnic_network}"
    network_card = "vmxnet3"
  }
  password     = "${var.vsphere_password}"
  ssh_password = "${var.guest_password}"
  ssh_timeout  = "${var.ssh_timeout}"
  ssh_username = "${var.guest_username}"
  storage {
    disk_size             = "${var.vm_disk_size}"
    disk_thin_provisioned = true
  }
  username       = "${var.vsphere_username}"
  vcenter_server = "${var.vsphere_vcenter}"
  vm_name        = "${var.vm_name1}"
}

###2nd source is the 2nd esxi to build...copy paste the source block to make as many esxi as you want, then update the build block, example further on in this script 
source "vsphere-iso" "esxi2" {
  CPUs                 = "${var.vm_cpu_size}"
  RAM                  = "${var.vm_ram_size}"
  boot_command         = ["<enter>", "<SHIFT+O>", " ks=nfs://${var.nfs_server_path}", "<enter>", ""]
  cluster              = "${var.vsphere_cluster}"
  communicator         = "ssh"
  convert_to_template  = "true"
  datacenter           = "${var.vsphere_datacenter}"
  datastore            = "${var.vsphere_datastore}"
  folder               = "${var.vsphere_template_folder}"
  guest_os_type        = "${var.vm_guestos}"
  host                 = "${var.parent_host}"
  insecure_connection  = true
  iso_paths            = ["[${var.vsphere_datastore}] ${var.iso_file_path}"]
  disk_controller_type    = ["${var.vm_disk_controller}"]
  network_adapters {
    network      = "${var.vnic_network}"
    network_card = "vmxnet3"
  }
  password     = "${var.vsphere_password}"
  ssh_password = "${var.guest_password}"
  ssh_timeout  = "${var.ssh_timeout}"
  ssh_username = "${var.guest_username}"
  storage {
    disk_size             = "${var.vm_disk_size}"
    disk_thin_provisioned = true
  }
  username       = "${var.vsphere_username}"
  vcenter_server = "${var.vsphere_vcenter}"
  vm_name        = "${var.vm_name2}"
}

build {
  sources = [
    "source.vsphere-iso.esxi1",
    "source.vsphere-iso.esxi2",
    ]
  

}


