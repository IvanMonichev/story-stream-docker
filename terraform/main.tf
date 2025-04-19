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


resource "twc_vpc" "story-stream-vpc" {
  name = "Story Stream VPC"
  subnet_v4 = "192.168.0.0/24"
  main_ipv4 = "188.225.46.223"
  location = "ru-1"
}

resource "twc_server" "v01" {
  name  = "Server Terraform"
  os_id = data.twc_os.ubuntu.id

  local_network {
    id = twc_vpc.story-stream-vpc.id
    ip = "192.168.0.15"
  }


  configuration {
    configurator_id = data.twc_configurator.configurator.id
    cpu             = 1
    ram             = 1024
    disk            = 15360
  }

  cloud_init = templatefile("./cloud-init.yaml.tftpl", {})

}

