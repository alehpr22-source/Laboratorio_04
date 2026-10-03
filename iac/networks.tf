resource "docker_network" "frontend_network" {
  name = "frontend_network-${terraform.workspace}"
  driver = "bridge"
}

resource "docker_network" "backend_network" {
  name = "backend_network-${terraform.workspace}"
  driver = "bridge"
}
