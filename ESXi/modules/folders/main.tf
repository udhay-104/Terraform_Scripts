data "vsphere_datacenter" "dc" {}

resource "vsphere_folder" "parent" {
    path          = "VMWorld"
    type          = "vm"
    datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_folder" "web" {
    path          = "${vsphere_folder.parent.path}/web"
    type          = "vm"
    datacenter_id = data.vsphere_datacenter.dc.id
}
