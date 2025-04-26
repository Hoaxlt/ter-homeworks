terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=1.8.4" 
}

resource "yandex_vpc_network" "develop" {
  name = var.env_name
}

resource "yandex_vpc_subnet" "self_subnet" {
  v4_cidr_blocks = var.v4_cidr_blocks
  zone           = var.zone
  network_id     = yandex_vpc_network.develop.id
  name           = "${var.env_name}-${var.zone}"
}