each_vm = [
    {
    vm_name = "main"
    zone = "ru-central1-a"
    cpu = 2
    ram = 1
    core_fraction = 5
    disk_volume = 10
    },        
    {
    vm_name = "replica"
    zone = "ru-central1-a"
    cpu = 2
    ram = 2
    core_fraction = 5
    disk_volume = 10
    }
  ]

  vm_metadata = {
    serial-port-enable = 1
    ssh-keys = "ubuntu:${file("~/tries.pub")}"
  }

  vm_storage = {
    vm_name = "storage"
    zone = "ru-central1-a"
    cpu = 2
    ram = 1
    disk_volume = 10
    core_fraction = 5 
    }
  

  vm_webservers = {
    zone = "ru-central1-a"
    cpu = 2
    ram = 1
    disk_volume = 10
    core_fraction = 5 
    }
  



