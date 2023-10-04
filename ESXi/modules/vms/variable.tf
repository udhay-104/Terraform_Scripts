variable "hosts" {
    type = list
    default = [
        "172.17.192.14"
    ]
}

variable "vms" {
    type = map(any)
    default = {
        ocp-controlplane1 = {
            name          = "ocp-controlplane1"
        },
        ocp-controlplane2 = {
            name          = "ocp-controlplane2"
        },
        ocp-controlplane3 = {
            name          = "ocp-controlplane3"
        },
        ocp-worker1 = {
            name          = "ocp-worker1"
        },
        ocp-worker2 = {
            name          = "ocp-worker2"
        }
    }
}