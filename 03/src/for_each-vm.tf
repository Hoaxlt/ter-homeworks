resource "yandex_compute_instance" "db" {
    for_each = {for o in var.each_vm : o.vm_name => o }
    name        = each.value.vm_name
    platform_id = each.value.platform_id
    zone        = each.value.zone

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id    = data.yandex_compute_image.ubuntu.image_id
      size        = each.value.disk_volume
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

