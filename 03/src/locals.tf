locals {
each_vm = [
    {
    vm_name = "main"
    cpu = 2
    ram = 1
    disk_volume = 10
    },        
    {
    vm_name = "replica"
    cpu = 2
    ram = 2
    disk_volume = 10
    }
  ]
}