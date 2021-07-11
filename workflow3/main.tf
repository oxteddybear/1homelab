module "nsxt" {
    source = "./nsxv"
    # Provider
    vsphere_user = "administrator@vsphere.local"
    vsphere_password = "VMware1!"
    vsphere_server = "192.168.254.133"

    # Infrastructure
    vsphere_datacenter = "nsxv-dc"
    compute_cluster = "compute-cluster"
    esxi_user = "root"
    esxi_password = "VMware1!"

    ####vds stuff
    vds1_name = "vdsmgt"
    vds2_name = "vdsdata"

    vds1_mtu = "1500"
    vds2_mtu = "9000"


}

module "nsxt" {
    source = "./nsxt"
    # Provider
    vsphere_user = "administrator@vsphere.local"
    vsphere_password = "VMware1!"
    vsphere_server = "192.168.254.132"

    # Infrastructure
    vsphere_datacenter = "nsxt-dc"
    compute_cluster = "compute-cluster"
    edge_cluster = "edge-cluster"
    esxi_user = "root"
    esxi_password = "VMware1!"

    ####vds stuff
    vds1_name = "vdsmgt"
    vds2_name = "vdsdata"

    vds1_mtu = "1500"
    vds2_mtu = "9000"

    
}