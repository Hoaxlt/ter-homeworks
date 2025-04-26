###cloud vars

variable "public_key" {
  type    = string
  default = "~/terra-ssh.pub"
}

variable "username" {
  type = string
  default = "ubuntu"
}

variable "packages" {
  type = string
  default = "vim, nginx"
}

variable "cloud_id" {
  type = string

}

variable "folder_id" {
  type = string

}

variable "analytics_vm_module" {
    type = object({ source=string, env_name=string, subnet_zones=list(string), subnet_ids=list(string),
                        instance_name=string, instance_count=number, image_family=string, labels=list(string) })
    default = {
              source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
              env_name       = "stage"
              subnet_zones   = ["ru-central1-a"]
              subnet_ids     = []
              instance_name  = "web-stage"
              instance_count = 1
              image_family   = "ubuntu-2004-lts"
              labels = ["p.petrov","analytics"]
                }
}

variable "marketing_vm_module" {
    type = object({ source=string, env_name=string, subnet_zones=list(string), subnet_ids=list(string),
                        instance_name=string, instance_count=number, image_family=string, labels=list(string) })
    default = {
              source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
              env_name       = "develop"
              subnet_zones   = ["ru-central1-a", "ru-central1-b"]
              subnet_ids     = []
              instance_name  = "webs"
              instance_count = 1
              image_family   = "ubuntu-2004-lts"


              labels = ["i.ivanov","marketing"]
    }
}