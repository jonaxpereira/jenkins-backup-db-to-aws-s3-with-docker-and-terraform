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
  name         = "jenkins:lts-jdk11"
  keep_locally = false
}

# containers

resource "docker_container" "jenkins" {
  image = docker_image.jenkins.name
  name  = "jenkins"
  ports {
    internal = 8080
    external = 8080
  }

  volumes {
    container_path = "/var/jenkins_home"
    host_path = "../../docker/jenkins/jenkins_home"
  }
}