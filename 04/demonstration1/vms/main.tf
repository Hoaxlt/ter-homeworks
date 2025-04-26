
module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  zone = "ru-central1-a"
  v4_cidr_blocks = ["10.0.1.0/24"]
}


module "marketing_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = var.marketing_vm_module.env_name 
  network_id     = module.vpc_dev.network_id
  subnet_zones   = var.marketing_vm_module.subnet_zones
  subnet_ids     = [module.vpc_dev.subnet_id]
  instance_name  = var.marketing_vm_module.instance_name
  instance_count = var.marketing_vm_module.instance_count
  image_family   = var.marketing_vm_module.image_family
  public_ip      = true

  labels = { 
    owner= var.marketing_vm_module.labels[0],
    project = var.marketing_vm_module.labels[1]
     }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}

module "analytics_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = var.analytics_vm_module.env_name
  network_id     = module.vpc_dev.network_id
  subnet_zones   = var.analytics_vm_module.subnet_zones
  subnet_ids     = [module.vpc_dev.subnet_id]
  instance_name  = var.analytics_vm_module.instance_name
  instance_count = var.analytics_vm_module.instance_count
  image_family   = var.analytics_vm_module.image_family
  public_ip      = true

  labels = { 
    owner= var.analytics_vm_module.labels[0],
    project = var.analytics_vm_module.labels[1]
     }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}

#Пример передачи cloud-config в ВМ для демонстрации №3
data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  
  vars = {
    username            = var.username
    ssh_public_key      = file(var.public_key)
    packages            = var.packages
  }
}

