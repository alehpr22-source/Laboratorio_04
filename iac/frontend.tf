# Find the latest Nginx image.
resource "docker_image" "frontend" {
  name = "nginx:latest"
}

# Start a container
resource "docker_container" "frontend" {
  name  = "web-${terraform.workspace}-${count.index + 1}"
  image = docker_image.frontend.image_id

  ports {
    internal = 80
    external = var.frontend_port[terraform.workspace]+count.index
  }

  networks_advanced {
    name = docker_network.frontend_network.name
  }
}

output "frontend_image_id"{
  value = docker_image.frontend.image_id
}