terraform {
  required_providers {
    twc = {
      source = "tf.timeweb.cloud/timeweb-cloud/timeweb-cloud"
    }
  }
  required_version = ">= 0.13"
}


provider "twc" {
  token = var.api_token
}

data "twc_configurator" "configurator" {
  location    = "ru-2"
  preset_type = "premium"
}

data "twc_os" "ubuntu" {
  name    = "ubuntu"
  version = "22.04"
}

resource "twc_server" "v_server" {
  name  = "Server Terraform"
  os_id = data.twc_os.ubuntu.id

  configuration {
    configurator_id = data.twc_configurator.configurator.id
    cpu             = 1
    ram             = 1024
    disk            = 15360
  }
}
