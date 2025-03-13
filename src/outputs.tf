output name_ip_fqdn_platform {
  value       = [yandex_compute_instance.platform.network_interface.0.nat_ip_address, yandex_compute_instance.platform.name, yandex_compute_instance.platform.fqdn ]
  sensitive   = false
  description = "description"
  depends_on  = []
}

output name_ip_fqdn_db {
  value       = [yandex_compute_instance.db.network_interface.0.nat_ip_address, yandex_compute_instance.db.name, yandex_compute_instance.db.fqdn ]
  sensitive   = false
  description = "description"
  depends_on  = []
}
