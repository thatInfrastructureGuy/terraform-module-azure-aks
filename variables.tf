variable "resource_group_name" {
  description = "Azure Resource Group Name"
}

variable "resource_group_location" {
  description = "Azure Resource Group location"
}

variable "worker_vm_count" {
  description = "Number of worker VMs to initially create"
  default     = "1"
}

variable "worker_os_type" {
  description = "Operating System for Worker Nodes"
  default     = "Linux"
}
variable "worker_os_disk_size" {
  description = "Azure VM OS Disk Size"
  default     = "30"
}

variable "worker_vm_size" {
  description = "Azure VM type"
  default     = "Standard_D8s_v3"
}

variable "kubernetes_version" {
  description = "Kubernetes Version to deploy"
  default     = "1.11.9"
}

variable "network_profile_plugin" {
  description = "Network Plugin to use. azure or kubenet"
  default     = "azure"
}

variable "network_profile_policy" {
  description = "Network Policy to use with AzureCNI"
  default     = "calico"
}

variable "azure_client_id" {
  description = "Azure Client ID"
  default     = ""
}

variable "azure_client_secret" {
  description = "Azure Client Secret"
  default     = ""
}

variable "ad_client_app_id" {
  description = "AAD Client App ID"
  default     = ""
}

variable "ad_server_app_id" {
  description = "AAD Server App ID"
  default     = ""
}

variable "ad_server_app_secret" {
  description = "AAD Server App Secret"
  default     = ""
}

variable "tag_environment" {
  description = "Tag: Cluster Environment"
  default     = ""
}

variable "tag_region" {
  description = "Tag: Cluster Environment"
  default     = ""
}

variable "tag_product" {
  description = "Tag: Cluster Product Lensferry/Nexus"
  default     = ""
}
