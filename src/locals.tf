locals {
env = "develop"
project = "platform"
role_d    = "db"
role_w    = "web"  
web_name  = "netology-${ local.env }-${ local.project }-${ local.role_w }"
db_name   = "netology-${ local.env }-${ local.project }-${ local.role_d }"
}
