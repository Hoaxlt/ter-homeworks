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
  name        = var.vm_storage.vm_name
  platform_id = "standard-v1"
  zone        = var.vm_storage.zone
 
  resources {
    cores         = var.vm_storage.cpu
    memory        = var.vm_storage.ram
    core_fraction = var.vm_storage.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vm_storage.disk_volume
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
    security_group_ids = [data.yandex_vpc_security_group.group1.security_group_id]
  }
  scheduling_policy {
        preemptible = true
  }
  
  metadata = local.vm_metadata
}
