resource "proxmox_virtual_environment_download_file" "debian_12_cloud" {
  for_each = toset(var.pm_cluster_nodes)

  content_type       = "iso"
  datastore_id       = "local"
  node_name          = each.value
  url                = "https://cloud.debian.org/images/cloud/bookworm/20241004-1890/debian-12-genericcloud-amd64-20241004-1890.qcow2"
  file_name          = "debian-12-genericcloud-amd64-20241004-1890.img"
  checksum           = "da84d609d7ec5645dae1df503ea72037b2a831401d1b42ce2e7ec2a840b699f07ca8aea630853a3d5430839268c2bd337be45d89498264c36a9b5e12872c59ee"
  checksum_algorithm = "sha512"
}
