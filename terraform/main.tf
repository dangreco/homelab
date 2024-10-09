module "host" {
  source = "./host"
}

module "files" {
  source           = "./files"
  pm_cluster_nodes = var.pm_cluster_nodes
}

module "vms" {
  source            = "./vms"
  pm_cluster_nodes  = var.pm_cluster_nodes
  k3s_server_nodes  = var.k3s_server_nodes
  k3s_agent_nodes   = var.k3s_agent_nodes
  debian_12_cloud   = module.files.debian_12_cloud
  cloud_init_config = module.files.cloud_init_config
}

