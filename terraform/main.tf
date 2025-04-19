terraform {
  required_providers {
    twc = {
      source = "tf.timeweb.cloud/timeweb-cloud/timeweb-cloud"
    }
  }
  required_version = ">= 0.13"
}


provider "twc" {
  token = "eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCIsImtpZCI6IjFrYnhacFJNQGJSI0tSbE1xS1lqIn0.eyJ1c2VyIjoiZGw3MDA0NCIsInR5cGUiOiJhcGlfa2V5IiwiYXBpX2tleV9pZCI6IjkzMzQ2ZWJhLTIxYjQtNDE4MC04NzI0LWE5NTIxN2FiMzIxMyIsImlhdCI6MTc0NDkxOTMwMX0.q5oZ0V>
}

data "twc_configurator" "configurator" {
  location = "ru-2"
  preset_type = "premium"
}

data "twc_os" "ubuntu" {
  name = "ubuntu"
  version = "22.04"
}

resource "twc_server" "v_server" {
  name = "Server Terraform"
  os_id = data.twc_os.ubuntu.id

  configuration {
    configurator_id = data.twc_configurator.configurator.id
    cpu = 1
    ram = 1024
    disk = 15360
  }
}
