terraform {
    required_providers {
        vsphere = {
            source = "hashicorp/vsphere"
            version = "2.2.0"
        }
    }
}

provider "vsphere" {
    user                 = "${var.vsphere_user}"
    password             = "${var.vsphere_password}"
    vsphere_server       = "${var.vsphere_node}"
    allow_unverified_ssl = true
}

module "folders" {
    source = "./modules/folders"
}

module "vms" {
    source = "./modules/vms"
}