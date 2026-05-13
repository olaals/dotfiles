variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-dev-vm"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "swedencentral"
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
  default     = "dev-vm"
}

variable "vm_size" {
  description = "Azure VM size"
  type        = string
  default     = "Standard_NV36ads_A10_v5"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "oalstdevvm"
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key"
  type        = string
  default     = "~/.ssh/dev-vm.pub"
}

variable "os_disk_size_gb" {
  description = "Size of the OS disk in GB"
  type        = number
  default     = 256
}

variable "spot_max_price" {
  description = "Max price per hour for spot VM in USD (-1 = up to on-demand)"
  type        = number
  default     = 3.0
}

variable "auto_shutdown_time" {
  description = "Daily auto-shutdown time in HHmm format"
  type        = string
  default     = "0300"
}

variable "auto_shutdown_timezone" {
  description = "Timezone for auto-shutdown"
  type        = string
  default     = "Romance Standard Time"
}
