resource "local_file" "ansible_inventory" {
  filename = "./inventory_test"
  content  = templatefile("${path.module}/ansible.tftpl", {
    webservers = yandex_compute_instance.webservers,
    db         = yandex_compute_instance.db,
    storage    = [yandex_compute_instance.storage]
  }
  )
}