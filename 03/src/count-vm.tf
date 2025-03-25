data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image
}

data "yandex_vpc_security_group" "group1" {
  security_group_id = "enpsdki7s3nqsg9qf34f"
}




resource "yandex_compute_instance" "webservers" {
    depends_on = [resource.yandex_compute_instance.db]
    count = 2
    name        = "web-${count.index + 1}"
    platform_id = "standard-v1"
    zone        = "ru-central1-a"

  resources {
    cores         = local.vm_webservers.cpu
    memory        = local.vm_webservers.ram
    core_fraction = local.vm_webservers.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = local.vm_webservers.disk_volume
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
