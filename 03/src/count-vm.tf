data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image
}

data "yandex_vpc_security_group" "group1" {
  security_group_id = yandex_vpc_security_group.example.name
}




resource "yandex_compute_instance" "webservers" {
    depends_on = [resource.yandex_compute_instance.db]
    count       = var.vm_webservers.count
    name        = "web-${count.index + 1}"
    platform_id = var.vm_webservers.platform_id
    zone        = var.vm_webservers.zone

  resources {
    cores         = var.vm_webservers.cpu
    memory        = var.vm_webservers.ram
    core_fraction = var.vm_webservers.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vm_webservers.disk_volume 
    }
  }
  network_interface {

    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [data.yandex_vpc_security_group.group1.security_group_id]
  }
    scheduling_policy {
        preemptible = true
  }
  metadata = local.vm_metadata
}
