variable "pm_user" {
  description = "The username for the proxmox user"
  type        = string
  sensitive   = false
  default     = "terraform-prov@pve"

}
variable "pm_password" {
  description = "The password for the proxmox user"
  type        = string
  sensitive   = true
}
variable "pm_tls_insecure" {
  description = "Set to true to ignore certificate errors"
  type        = bool
  default     = false
}
variable "pm_host" {
  description = "The hostname or IP of the proxmox server"
  type        = string
}
variable "pm_node_name" {
  description = "Name of the proxmox node to create the VMs on"
  type        = string
  default     = "pve"
}

variable "pm_cluster_nodes" {
  description = "Node names of Proxmox VE cluster nodes"
  type        = list(string)
  default     = []
}

variable "k3s_server_nodes" {
  type    = number
  default = 1
}

variable "k3s_agent_nodes" {
  type    = number
  default = 2
}

