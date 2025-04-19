terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
    twc = {
      source = "tf.timeweb.cloud/timeweb-cloud/timeweb-cloud"
    }

  }
  required_version = ">= 0.13"
}

resource "docker_image" "nginx" {
  name         = "nginx"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "tutorial"

  ports {
    internal = 8080
    external = 8000
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

  configuration {
    configurator_id = data.twc_configurator.configurator.id
    cpu             = 1
    ram             = 1024
    disk            = 15360
  }
}

