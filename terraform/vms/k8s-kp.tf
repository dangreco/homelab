locals {
  kp_host_indices = { for idx, host in var.pm_cluster_nodes : host => idx + 1 }

  kp_vm_instances = flatten([
    for host in var.pm_cluster_nodes : [
      for i in range(var.k8s_control_nodes) : {
        host     = host
        n        = i
        host_idx = local.kp_host_indices[host]
        ip       = format("192.168.2.%d/24", 100 + (local.kp_host_indices[host] * 10) + i)
      }
    ]
  ])
}

# k8s control planes
resource "proxmox_virtual_environment_vm" "k8s-kp" {
  for_each = { for i, v in local.kp_vm_instances : i => v }

  name      = "k8s-kp-${each.key}"
  node_name = each.value.host
  vm_id     = 7000 + (each.value.host_idx * 100) + each.value.n

  cpu {
    cores = 2
  }

  memory {
    dedicated = 4096
  }

  agent {
    enabled = true
  }

  network_device {
    bridge = "vmbr0"
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = var.debian_12_cloud[each.value.host]
    interface    = "virtio0"
    iothread     = true
    size         = 32
    discard      = "on"
    ssd          = true
    backup       = false
  }

  boot_order = ["virtio0"]

  serial_device {}

  operating_system {
    type = "l26"
  }

  initialization {
    ip_config {
      ipv4 {
        gateway = "192.168.2.1"
        address = each.value.ip
      }
    }

    user_data_file_id = var.cloud_init_config[each.value.host]
  }
}
