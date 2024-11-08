terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "my_docker_image" {
  name         = "vlnnns/frontend:latest"  # Путь к образу Docker Hub
  keep_locally = false
}

resource "docker_container" "my_container" {
  name  = "my_container_name"
  image = docker_image.my_docker_image.latest

  ports {
    internal = 3000
    external = 8080
  }

  command = [
    "node",
    "--max-old-space-size=4096",
    "node_modules/.bin/react-scripts",
    "start"
  ]

  env = [
    "NODE_ENV=development",  # Пример переменной окружения
    "REACT_APP_API_BASE_URL=http://localhost:8080",
"NODE_OPTIONS=--max-old-space-size=4096",
  ]
}

