variable "pm_cluster_nodes" {
  description = "Node names of Proxmox VE cluster nodes"
  type        = list(string)
  default     = []
}
