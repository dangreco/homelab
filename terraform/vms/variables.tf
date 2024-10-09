variable "pm_cluster_nodes" {
  description = "Node names of Proxmox VE cluster nodes"
  type        = list(string)
  default     = []
}

variable "k3s_server_nodes" {
  type    = number
}

variable "k3s_agent_nodes" {
  type    = number
}

variable "debian_12_cloud" {
  type = map(string)
}

variable "cloud_init_config" {
  type = map(string)
}

