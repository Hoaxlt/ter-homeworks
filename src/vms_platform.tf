

variable "vm_db_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "ubuntu-2004 image for vm"
}

variable "vm_db_platform_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "name for web platform"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "platform id"
}

variable "vm_db_cores" {
  type        = number
  default     = 2
  description = "web cores number"
}

variable "vm_db_memory" {
  type        = number
  default     = 2
  description = "web memory number"
}

variable "vm_db_core_fraction" {
  type        = number
  default     = 20
  description = "% of efficency cores"
}
