data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image
}





resource "yandex_compute_instance" "webservers" {
    depends_on = [resource.yandex_compute_instance.db]
    count = 2
    name        = "web-${count.index + 1}"
    platform_id = "standard-v1"
    zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 1
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  network_interface {

    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = (var.security_id)
  }
    scheduling_policy {
        preemptible = true
  }
  metadata = {
    serial-port-enable = 1
    ssh-keys = "ubuntu:${file("~/tries.pub")}"
  }
}
