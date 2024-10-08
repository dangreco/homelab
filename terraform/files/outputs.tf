output "debian_12_cloud" {
  value = {
    for host in var.pm_cluster_nodes : host => proxmox_virtual_environment_download_file.debian_12_cloud[host].id
  }
}

output "cloud_init_config" {
  value = {
    for host in var.pm_cluster_nodes : host => proxmox_virtual_environment_file.cloud_init_config[host].id
  }
}
