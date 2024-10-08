locals {
  wk_host_indices = { for idx, host in var.pm_cluster_nodes : host => idx + 1 }

  wk_vm_instances = flatten([
    for host in var.pm_cluster_nodes : [
      for i in range(var.k8s_worker_nodes) : {
        host     = host
        n        = i
        host_idx = local.wk_host_indices[host]
        ip       = format("192.168.2.%d/24", 100 + (local.wk_host_indices[host] * 10) + i + 1)
      }
    ]
  ])
}

# k8s workers
resource "proxmox_virtual_environment_vm" "k8s-wk" {
  for_each = { for i, v in local.wk_vm_instances : i => v }

  name      = "k8s-wk-${each.key}"
  node_name = each.value.host
  vm_id     = 7000 + (each.value.host_idx * 100) + ((each.value.n + 1) * 10)

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
