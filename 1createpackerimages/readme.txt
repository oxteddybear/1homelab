Title: Using Packer to preinstall nested esxi.


reference: https://path2.cloud/post/automated-esxi-nested-lab-installation/
converted the original workflow 1 to HCL this enables the "build" block so we can run pararell sources. i.e. build more then 1 esxi.


Files
=====
3 files are needed. (The files NEED to be named with .pkr.hcl)
	- varvalues2.pkr.hcl <<<put the constants here
	- esxi2.pkr.hcl <<< main configuration file where you modify varaibles, etc etc.
	- ks.cfg << kickstart file for esxi on a nfs mount.

build location
==============
The vms are going to get built in the folder "Packer_vm" on vsphere, so make sure it exists. you can change this in the varvalues.pkr.hcl file.

Steps
=====

1. install packer - https://learn.hashicorp.com/tutorials/packer/get-started-install-cli
2. run "packer init" to find missing plugins. 
	- uses the packer-builder-vsphere plugin, this has been merged into the official packer core.
3. run "packer build -var-file=varvalues2.pkr.hcl esxi2.pkr.hcl"


other Attributes you can use but not documented in official packer document
===========================================================================

the parameters are below for safe keeping, in case https://github.com/jetbrains-infra/packer-builder-vsphere is taken down.


Files
README.md
Team project GitHub latest release GitHub downloads TeamCity build status

Deprecation notice
This plugin was merged into official Packer repository and released with Packer since version 1.5.2.

Please use modern version of Packer and report problems, feature suggestions to main Packer repository.

This repository left for history and archived.

Packer Builder for VMware vSphere
This a plugin for HashiCorp Packer. It uses native vSphere API, and creates virtual machines remotely.

vsphere-iso builder creates new VMs from scratch. vsphere-clone builder clones VMs from existing templates.

VMware Player is not required.
Official vCenter API is used, no ESXi host modification is required.
Installation
Download binaries from the releases page.
Install the plugins, or simply put them into the same directory with JSON templates. On Linux and macOS run chmod +x on the files.
Build
Install Go and dep, run build.sh.

Or build inside a container by Docker Compose:

docker-compose run build
The binaries will be in bin/ directory.

Artifacts can be also downloaded from TeamCity builds.

Examples
See complete Ubuntu, Windows, and macOS templates in the examples folder.

Parameter Reference
Connection
vcenter_server(string) - vCenter server hostname.
username(string) - vSphere username.
password(string) - vSphere password.
insecure_connection(boolean) - Do not validate vCenter server's TLS certificate. Defaults to false.
datacenter(string) - VMware datacenter name. Required if there is more than one datacenter in vCenter.
VM Location
vm_name(string) - Name of the new VM to create.
folder(string) - VM folder to create the VM in.
host(string) - ESXi host where target VM is created. A full path must be specified if the host is in a folder. For example folder/host. See the Specifying Clusters and Hosts section above for more details.
cluster(string) - ESXi cluster where target VM is created. See Working with Clusters.
resource_pool(string) - VMWare resource pool. Defaults to the root resource pool of the host or cluster.
datastore(string) - VMWare datastore. Required if host is a cluster, or if host has multiple datastores.
notes(string) - VM notes.
VM Location (vsphere-clone only)
template(string) - Name of source VM. Path is optional.
linked_clone(boolean) - Create VM as a linked clone from latest snapshot. Defaults to false.
Hardware
CPUs(number) - Number of CPU sockets.
cpu_cores(number) - Number of CPU cores per socket.
CPU_limit(number) - Upper limit of available CPU resources in MHz.
CPU_reservation(number) - Amount of reserved CPU resources in MHz.
CPU_hot_plug(boolean) - Enable CPU hot plug setting for virtual machine. Defaults to false.
RAM(number) - Amount of RAM in MB.
RAM_reservation(number) - Amount of reserved RAM in MB.
RAM_reserve_all(boolean) - Reserve all available RAM. Defaults to false. Cannot be used together with RAM_reservation.
RAM_hot_plug(boolean) - Enable RAM hot plug setting for virtual machine. Defaults to false.
video_ram(number) - Amount of video memory in MB.
disk_size(number) - The size of the disk in MB.
network(string) - Set network VM will be connected to.
NestedHV(boolean) - Enable nested hardware virtualization for VM. Defaults to false.
configuration_parameters(map) - Custom parameters.
boot_order(string) - Priority of boot devices. Defaults to disk,cdrom
Hardware (vsphere-iso only)
vm_version(number) - Set VM hardware version. Defaults to the most current VM hardware version supported by vCenter. See VMWare article 1003746 for the full list of supported VM hardware versions.
guest_os_type(string) - Set VM OS type. Defaults to otherGuest. See here for a full list of possible values.
disk_controller_type(string) - Set VM disk controller type. Example pvscsi.
disk_thin_provisioned(boolean) - Enable VMDK thin provisioning for VM. Defaults to false.
network_card(string) - Set VM network card type. Example vmxnet3.
usb_controller(boolean) - Create USB controller for virtual machine. Defaults to false.
cdrom_type(string) - Which controller to use. Example sata. Defaults to ide.
firmware(string) - Set the Firmware at machine creation. Example efi. Defaults to bios.
Boot (vsphere-iso only)
iso_paths(array of strings) - List of datastore paths to ISO files that will be mounted to the VM. Example "[datastore1] ISO/ubuntu.iso".
floppy_files(array of strings) - List of local files to be mounted to the VM floppy drive. Can be used to make Debian preseed or RHEL kickstart files available to the VM.
floppy_dirs(array of strings) - List of directories to copy files from.
floppy_img_path(string) - Datastore path to a floppy image that will be mounted to the VM. Example [datastore1] ISO/pvscsi-Windows8.flp.
http_directory(string) - Path to a directory to serve using a local HTTP server. Beware of limitations.
http_ip(string) - Specify IP address on which the HTTP server is started. If not provided the first non-loopback interface is used.
http_port_min and http_port_max as in other builders.
iso_urls(array of strings) - Multiple URLs for the ISO to download. Packer will try these in order. If anything goes wrong attempting to download or while downloading a single URL, it will move on to the next. All URLs must point to the same file (same checksum). By default this is empty and iso_url is used. Only one of iso_url or iso_urls can be specified.
iso_checksum (string) - The checksum for the OS ISO file. Because ISO files are so large, this is required and Packer will verify it prior to booting a virtual machine with the ISO attached. The type of the checksum is specified with iso_checksum_type, documented below. At least one of iso_checksum and iso_checksum_url must be defined. This has precedence over iso_checksum_url type.
iso_checksum_type(string) - The type of the checksum specified in iso_checksum. Valid values are none, md5, sha1, sha256, or sha512 currently. While none will skip checksumming, this is not recommended since ISO files are generally large and corruption does happen from time to time.
iso_checksum_url(string) - A URL to a GNU or BSD style checksum file containing a checksum for the OS ISO file. At least one of iso_checksum and iso_checksum_url must be defined. This will be ignored if iso_checksum is non empty.
boot_wait(string) Amount of time to wait for the VM to boot. Examples 45s and 10m. Defaults to 10 seconds. See format.
boot_command(array of strings) - List of commands to type when the VM is first booted. Used to initalize the operating system installer. See details in Packer docs.
Provision
communicator - ssh (default), winrm, or none (create/clone, customize hardware, but do not boot).
ip_wait_timeout(string) - Amount of time to wait for VM's IP, similar to 'ssh_timeout'. Defaults to 30m (30 minutes). See the Go Lang ParseDuration documentation for full details.
ip_settle_timeout(string) - Amount of time to wait for VM's IP to settle down, sometimes VM may report incorrect IP initially, then its recommended to set that parameter to apx. 2 minutes. Examples 45s and 10m. Defaults to 5s(5 seconds). See the Go Lang ParseDuration documentation for full details.
ssh_username(string) - Username in guest OS.
ssh_password(string) - Password to access guest OS. Only specify ssh_password or ssh_private_key_file, but not both.
ssh_private_key_file(string) - Path to the SSH private key file to access guest OS. Only specify ssh_password or ssh_private_key_file, but not both.
winrm_username(string) - Username in guest OS.
winrm_password(string) - Password to access guest OS.
shutdown_command(string) - Specify a VM guest shutdown command. VMware guest tools are used by default.
shutdown_timeout(string) - Amount of time to wait for graceful VM shutdown. Examples 45s and 10m. Defaults to 5m(5 minutes). See the Go Lang ParseDuration documentation for full details.
Postprocessing
create_snapshot(boolean) - Create a snapshot when set to true, so the VM can be used as a base for linked clones. Defaults to false.
convert_to_template(boolean) - Convert VM to a template. Defaults to false.
Working with Clusters
Standalone Hosts
Only use the host option. Optionally specify a resource_pool:

"host": "esxi-1.vsphere65.test",
"resource_pool": "pool1",
Clusters Without DRS
Use the cluster and host parameters:

"cluster": "cluster1",
"host": "esxi-2.vsphere65.test",
Clusters With DRS
Only use the cluster option. Optionally specify a resource_pool:

"cluster": "cluster2",
"resource_pool": "pool1",
Required vSphere Permissions
VM folder (this object and children):
Virtual machine -> Inventory
Virtual machine -> Configuration
Virtual machine -> Interaction
Virtual machine -> Snapshot management
Virtual machine -> Provisioning
Individual privileges are listed in https://github.com/jetbrains-infra/packer-builder-vsphere/issues/97#issuecomment-436063235.
Resource pool, host, or cluster (this object):
Resource -> Assign virtual machine to resource pool
Host in clusters without DRS (this object):
Read-only
Datastore (this object):
Datastore -> Allocate space
Datastore -> Browse datastore
Datastore -> Low level file operations
Network (this object):
Network -> Assign network
Distributed switch (this object):
Read-only
For floppy image upload:

Datacenter (this object):
Datastore -> Low level file operations
Host (this object):
Host -> Configuration -> System Management
