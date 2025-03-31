locals {
   vm_metadata = {
    serial-port-enable = 1
    ssh-keys = "ubuntu:${file("~/tries.pub")}"
  }
}