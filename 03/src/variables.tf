###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}


variable "vm_web_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "ubuntu-2004 image for vm"
}



variable "each_vm" {
  type    = list(object({  vm_name=string, platform_id=string, zone=string, cpu=number, ram=number, disk_volume=number, core_fraction=number }))
  default = [
              {
              vm_name = "main"
              platform_id = "standard-v1"
              zone = "ru-central1-a"
              cpu = 2
              ram = 1
              disk_volume = 10
              core_fraction = 5
              },
              
              
              {
                vm_name = "replica"
                platform_id = "standard-v1"
                zone = "ru-central1-a"
                cpu = 2 
                ram = 2
                disk_volume = 10
                core_fraction = 5
              }
  ]
}


variable "vm_storage" {
  type  = object({ vm_name=string, platform_id=string, zone=string, cpu=number, ram=number, disk_volume=number, core_fraction=number})

}

variable "vm_webservers" {
  type  = object({ count=number, platform_id=string, zone=string, cpu=number, ram=number, disk_volume=number, core_fraction=number})

}

variable "virtual_disk" {
  type = object({ count=number, type=string, size=number, zone=string, environment=string})
}

