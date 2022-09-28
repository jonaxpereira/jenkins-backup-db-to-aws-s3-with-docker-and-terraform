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

# images

resource "docker_image" "jenkins" {
  name         = "jenkins/jenkins:lts-jdk11"
  keep_locally = false
}

resource "docker_image" "remote-host" {
  name = "remote-host"
  build {
    path = "../../docker/centos7"
    tag  = ["develop"]
  }
}

# containers

resource "docker_container" "jenkins" {
  name  = "jenkins"
  image = docker_image.jenkins.name
  ports {
    internal = 8080
    external = 8080
  }

  volumes {
    volume_name    = docker_volume.jenkins.name
    container_path = "/var/jenkins_home"
  }

  networks_advanced {
    name = docker_network.net.name
  }
}

resource "docker_container" "remote-host" {
  name  = "remote-host"
  image = docker_image.remote-host.name

  networks_advanced {
    name = docker_network.net.name
  }
}

# volumes

resource "docker_volume" "jenkins" {
  name = "jenkins"
}

# networks

resource "docker_network" "net" {
  name = "net"
}
