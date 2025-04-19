terraform {
  required_providers {
    twc = {
      source = "tf.timeweb.cloud/timeweb-cloud/timeweb-cloud"
    }
  }
  required_version = ">= 0.13"
}


provider "twc" {
  token   = var.api_token
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
  name      = "Story Stream VPC"
  subnet_v4 = "192.168.0.0/24"
  location  = "ru-1"
}


data "twc_presets" "twc-preset" {
  price_filter {
    from = 300
    to   = 400
  }
}

resource "twc_server" "story-stream-server" {
  name      = "Server Terraform"
  os_id     = data.twc_os.ubuntu.id
  preset_id = data.twc_presets.twc-preset.id

#   configuration {
#     configurator_id = data.twc_configurator.configurator.id
#     cpu             = 1
#     ram             = 1024
#     disk            = 15360
#   }

  cloud_init = templatefile("./cloud-init.yaml.tftpl", {})

}

# Usage example for create additional IP address
resource "twc_server_ip" "example" {
  source_server_id = twc_server.story-stream-server.id

  type = "ipv4"
  ptr  = "188.225.46.223"
}
