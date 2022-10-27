variable vsphere_vcenter           {  default = "" }
variable vsphere_username          {  default = "" }

variable vsphere_password          {  default = "" }
variable vsphere_datacenter        {  default = "" }
variable vsphere_cluster           {  default = "" }
variable parent_host               {  default = "" }
variable parent_host108               {  default = "" }
variable vsphere_datastore         {  default = "" }
variable vsphere_template_folder   {  default = "" }
variable vm_name1                  {  default = "" }
variable vm_name2                  {  default = "" }
variable vm_name3                  {  default = "" }
variable vm_name4                  {  default = "" }
variable vm_name5                  {  default = "" }
variable vm_name6                  {  default = "" }


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


source "vsphere-iso" "esxi5" {
  CPUs                 = "${var.vm_cpu_size}"
  RAM                  = "${var.vm_ram_size}"
  NestedHV             = "true"
  boot_command         = ["<enter>", "<SHIFT+O>", " ks=nfs://${var.nfs_server_path}", "<enter>", ""]
#  cluster              = "${var.vsphere_cluster}"
  communicator         = "ssh"
  convert_to_template  = "true"
  datacenter           = "${var.vsphere_datacenter}"
  datastore            = "${var.vsphere_datastore}"
  folder               = "${var.vsphere_template_folder}"
  guest_os_type        = "${var.vm_guestos}"
  host                 = "${var.parent_host108}"
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
  vm_name        = "${var.vm_name5}"
}

source "vsphere-iso" "esxi6" {
  CPUs                 = "${var.vm_cpu_size}"
  RAM                  = "${var.vm_ram_size}"
  NestedHV             = "true"
  boot_command         = ["<enter>", "<SHIFT+O>", " ks=nfs://${var.nfs_server_path}", "<enter>", ""]
#  cluster              = "${var.vsphere_cluster}"
  communicator         = "ssh"
  convert_to_template  = "true"
  datacenter           = "${var.vsphere_datacenter}"
  datastore            = "${var.vsphere_datastore}"
  folder               = "${var.vsphere_template_folder}"
  guest_os_type        = "${var.vm_guestos}"
  host                 = "${var.parent_host108}"
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
  vm_name        = "${var.vm_name6}"
}
##maximium packer can build is 5 vms that's y have to split into 2 hcl files
build {
  sources = [

	"source.vsphere-iso.esxi6",
	"source.vsphere-iso.esxi5"
	
	
  ]
  

}


