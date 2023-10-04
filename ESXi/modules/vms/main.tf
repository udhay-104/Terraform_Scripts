data "vsphere_datacenter" "dc" {
    name = "CTIO_LAB"
}

data "vsphere_datastore" "datastore" {
    name          = "datastore1"
    datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "ocp_network" {
    name          = "OCP"
    datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "mgmt_network" {
    name          = "MGMT NW"
    datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_host" "host" {
    name          = "172.17.192.14"
    datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "centos_template" {
  name          = "Centos8_Template"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "ocp-helpernode" {
    name                 = "ocp-helpernode"
    resource_pool_id     = data.vsphere_host.host.resource_pool_id
    datastore_id         = data.vsphere_datastore.datastore.id
    num_cpus             = 4
    memory               = 8192
    guest_id             = data.vsphere_virtual_machine.centos_template.guest_id
    firmware             = data.vsphere_virtual_machine.centos_template.firmware
    network_interface {
        network_id       = data.vsphere_network.mgmt_network.id
    }
    network_interface {
        network_id       = data.vsphere_network.ocp_network.id
    }
    disk {
        label            = "ocp-vm1.vmdk"
        size             = data.vsphere_virtual_machine.centos_template.disks.0.size
        thin_provisioned = data.vsphere_virtual_machine.centos_template.disks.0.thin_provisioned
    }
    clone {
        template_uuid    = data.vsphere_virtual_machine.centos_template.id
    }
}

resource "vsphere_virtual_machine" "ocp-bootstrap" {
    name                 = "ocp-bootstrap"
    datastore_id         = data.vsphere_datastore.datastore.id
    resource_pool_id     = data.vsphere_host.host.resource_pool_id
    num_cpus             = 8
    memory               = 32768
    guest_id             = "coreos64Guest"
    cdrom {
        datastore_id     = data.vsphere_datastore.datastore.id
        path             = "Images/rhcos-4.13.5-x86_64-live.x86_64.iso"   
    }
    network_interface {
        network_id       = data.vsphere_network.ocp_network.id
        use_static_mac   = true
        mac_address      = "00:00:11:00:01:01"
    }
    disk {
        label            = "ocp-bootstrap"
        size             = 150
    }
}

resource "vsphere_virtual_machine" "ocp-master1" {
    name                 = "ocp-master1"
    datastore_id         = data.vsphere_datastore.datastore.id
    resource_pool_id     = data.vsphere_host.host.resource_pool_id
    num_cpus             = 8
    memory               = 32768
    guest_id             = "coreos64Guest"
    cdrom {
        datastore_id     = data.vsphere_datastore.datastore.id
        path             = "Images/rhcos-4.13.5-x86_64-live.x86_64.iso"   
    }
    network_interface {
        network_id       = data.vsphere_network.ocp_network.id
        use_static_mac   = true
        mac_address      = "00:00:11:00:02:01"
    }
    disk {
        label            = "ocp-master1"
        size             = 150
    }
}

resource "vsphere_virtual_machine" "ocp-master2" {
    name                 = "ocp-master2"
    datastore_id         = data.vsphere_datastore.datastore.id
    resource_pool_id     = data.vsphere_host.host.resource_pool_id
    num_cpus             = 8
    memory               = 32768
    guest_id             = "coreos64Guest"
    cdrom {
        datastore_id     = data.vsphere_datastore.datastore.id
        path             = "Images/rhcos-4.13.5-x86_64-live.x86_64.iso"   
    }
    network_interface {
        network_id       = data.vsphere_network.ocp_network.id
        use_static_mac   = true
        mac_address      = "00:00:11:00:02:02"
    }
    disk {
        label            = "ocp-master2"
        size             = 150
    }
}

resource "vsphere_virtual_machine" "ocp-master3" {
    name                 = "ocp-master3"
    datastore_id         = data.vsphere_datastore.datastore.id
    resource_pool_id     = data.vsphere_host.host.resource_pool_id
    num_cpus             = 8
    memory               = 32768
    guest_id             = "coreos64Guest"
    cdrom {
        datastore_id     = data.vsphere_datastore.datastore.id
        path             = "Images/rhcos-4.13.5-x86_64-live.x86_64.iso"   
    }
    network_interface {
        network_id       = data.vsphere_network.ocp_network.id
        use_static_mac   = true
        mac_address      = "00:00:11:00:02:03"
    }
    disk {
        label            = "ocp-master3"
        size             = 150
    }
}

resource "vsphere_virtual_machine" "ocp-worker1" {
    name                 = "ocp-worker1"
    datastore_id         = data.vsphere_datastore.datastore.id
    resource_pool_id     = data.vsphere_host.host.resource_pool_id
    num_cpus             = 8
    memory               = 32768
    guest_id             = "coreos64Guest"
    cdrom {
        datastore_id     = data.vsphere_datastore.datastore.id
        path             = "Images/rhcos-4.13.5-x86_64-live.x86_64.iso"   
    }
    network_interface {
        network_id       = data.vsphere_network.ocp_network.id
        use_static_mac   = true
        mac_address      = "00:00:11:00:03:01"
    }
    disk {
        label            = "ocp-worker1"
        size             = 150
    }
}

resource "vsphere_virtual_machine" "ocp-worker2" {
    name                 = "ocp-worker2"
    datastore_id         = data.vsphere_datastore.datastore.id
    resource_pool_id     = data.vsphere_host.host.resource_pool_id
    num_cpus             = 8
    memory               = 32768
    guest_id             = "coreos64Guest"
    cdrom {
        datastore_id     = data.vsphere_datastore.datastore.id
        path             = "Images/rhcos-4.13.5-x86_64-live.x86_64.iso"   
    }
    network_interface {
        network_id       = data.vsphere_network.ocp_network.id
        use_static_mac   = true
        mac_address      = "00:00:11:00:03:02"
    }
    disk {
        label            = "ocp-worker2"
        size             = 150
    }
}
