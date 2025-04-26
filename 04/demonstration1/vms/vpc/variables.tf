
variable "zone" {
  type = string
  default = "ru-central1-a"
}

variable "v4_cidr_blocks" {
  type = list
  default = ["10.2.0.0/16"]
}

variable "env_name" {
    type = string
    default = "develop"
}

