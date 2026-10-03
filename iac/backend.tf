# Find the latest nmatsui/hello-world-api image.
resource "docker_image" "backend" {
  name = "nmatsui/hello-world-api:latest"
}

# Start a container
resource "docker_container" "backend" {
  count = var.backend_replicas[terraform.workspace]
  name  = "api-${terraform.workspace}-${count.index + 1}"
  # version larga: name  = var.backend_replicas[terraform.workspace] > 1 ? 
  # "api-${terraform.workspace}-${count.index + 1}" : "api-${terraform.workspace}"
  image = docker_image.backend.image_id

  ports {
    internal = 3000
    external = var.backend_port[terraform.workspace]+count.index
  }

  networks_advanced {
    name = docker_network.backend_network.name
  }

  networks_advanced {
    name = docker_network.frontend_network.name
  }
}

output "backend_image_id" {
  value = docker_image.backend.image_id
}