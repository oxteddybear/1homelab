module "nsxt" {
    source = "./nsxt"
    # Provider
    vsphere_user = "administrator@vsphere.local"
    vsphere_password = "VMware1!"
    vsphere_server = "192.168.254.133"

    # Infrastructure
    vsphere_datacenter = "nsxt-dc"
    compute_cluster = "Prod"
    edge_cluster = "Staging"
    esxi_user = "root"
    esxi_password = "VMware1!"

    ####vds stuff
    vds1_name = "vds-mgt"
    vds2_name = "vds-prod-data"
    vds3_name = "vds-staging-data"

    vds1_mtu = "1500"
    vds2_mtu = "1700"
    vds3_mtu = "1700"
    
}