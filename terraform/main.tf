terraform {
  required_providers {
    twc = {
      source = "tf.timeweb.cloud/timeweb-cloud/timeweb-cloud"
    }

  }
  required_version = ">= 0.13"
}

resource "timeweb_vpc_network" "default" {
  name = "story-stream-net"
}

resource "timeweb_vpc_subnet" "default" {
  name           = "story-stream-subnet"
  zone           = "ru-2"
  v4_cidr_blocks = ["10.0.0.0/16"]
  network_id     = timeweb_vpc_network.default.id
}

resource "timeweb_vpc_security_group" "default" {
  name       = "story-stream-sg"
  network_id = timeweb_vpc_network.default.id

  ingress {
    description    = "Allow all inbound traffic"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description    = "Allow all inbound traffic"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
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

resource "twc_server" "v01" {
  name  = "Server Terraform"
  os_id = data.twc_os.ubuntu.id

  network_interface {
    subnet_id          = timeweb_vpc_subnet.default.id
    nat                = true
    security_group_ids = [timeweb_vpc_security_group.default.id]
  }


  configuration {
    configurator_id = data.twc_configurator.configurator.id
    cpu             = 1
    ram             = 1024
    disk            = 15360
  }
}

