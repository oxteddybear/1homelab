module "nsxt" {
    source = "./nsxt"
    # Provider
    vsphere_user = "administrator@vsphere.local"
    vsphere_password = "VMware1!"
    vsphere_server = "192.168.254.133"

    # Infrastructure
    vsphere_datacenter = "nsxt-dc"
    compute_cluster = "clusterm"
    edge_cluster = "cluster-greenfield"
    esxi_user = "root"
    esxi_password = "VMware1!"

    ####vds stuff
    vds1_name = "vds-clusterm-mgt"
    vds2_name = "vds-clusterm-data"
    vds3_name = "vds-clustergreen-data"

    vds1_mtu = "1500"
    vds2_mtu = "1700"
    vds3_mtu = "1700"
    
}