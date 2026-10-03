# Find the latest postgres image.
resource "docker_image" "database" {
  name = "postgres:latest"
}

# Start a container
resource "docker_container" "database" {
  name  = "db-${terraform.workspace}"
  image = docker_image.database.image_id

  env = [
    "POSTGRES_PASSWORD=${var.POSTGRES_PASSWORD}",
    "POSTGRES_USER=${var.POSTGRES_USER}"
  ]

  ports {
    internal = 5432
    external = var.database_port[terraform.workspace]
  }

  networks_advanced {
    name = docker_network.backend_network.name
  }
}

output "database_image_id" {
  value = docker_image.database.image_id
}