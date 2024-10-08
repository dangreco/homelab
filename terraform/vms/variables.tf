variable "pm_cluster_nodes" {
  description = "Node names of Proxmox VE cluster nodes"
  type        = list(string)
  default     = []
}

variable "k8s_control_nodes" {
  type    = number
  default = 1
}

variable "k8s_worker_nodes" {
  type    = number
  default = 1
}

variable "debian_12_cloud" {
  type = map(string)
}

variable "cloud_init_config" {
  type = map(string)
}

