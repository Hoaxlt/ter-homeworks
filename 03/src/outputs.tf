output disks {
    value = [yandex_compute_disk.default.*.id]
    description = "yadisks"
}