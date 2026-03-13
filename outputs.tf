output "host" {
  description = "Hostname of the Elasticsearch container."
  value       = docker_container.server.hostname
}

output "port" {
  description = "HTTP port bound by Elasticsearch."
  value       = var.port
}
