terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.22.0"
    }
  }
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine"
}

resource "docker_image" "jenkins" {
  name         = "jenkins:lts-jdk11"
  keep_locally = false
}

resource "docker_container" "jenkins" {
  image = docker_image.jenkins.name
  name  = "jenkins"
  ports {
    internal = 8080
    external = 8080
  }
}
