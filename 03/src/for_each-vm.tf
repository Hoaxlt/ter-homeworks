resource "yandex_compute_instance" "db" {
    for_each = {for o in var.each_vm : o.vm_name => o }
    name        = each.value.vm_name
    platform_id = "standard-v1"
    zone        = "ru-central1-a"

  resources {
    cores  = each.value.cpu
    memory = each.value.ram
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size = each.value.disk_volume
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

