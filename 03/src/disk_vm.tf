resource "yandex_compute_disk" "default" {
    count  = 3
  name     = "disk-${count.index + 1}"
  type     = "network-hdd"
  size     = 1
  zone     = "ru-central1-a"
 

  labels = {
    environment = "test"
  }
}


resource "yandex_compute_instance" "storage" {
  depends_on  = [yandex_compute_disk.default]
  name        = "storage"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"
  # for_each    = toset(yandex_compute_disk.default.*.id)
 

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

   dynamic "secondary_disk" {
    for_each    = { for disk in yandex_compute_disk.default[*]: disk.name=> disk}
    content {
      disk_id = secondary_disk.value.id
 
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
