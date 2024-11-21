output "host" {
  value = docker_container.server.hostname
}

output "port" {
  value = var.port
}
