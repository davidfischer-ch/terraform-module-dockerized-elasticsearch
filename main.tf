resource "docker_container" "server" {

  image = var.image_id
  name  = var.identifier

  must_run = var.enabled
  start    = var.enabled
  restart  = "always"
  wait     = var.wait

  # shm_size = 256 # MB

  command = []

  env = formatlist("%s=%s", keys(var.env), values(var.env))

  dynamic "host" {
    for_each = var.hosts
    content {
      host = host.key
      ip   = host.value
    }
  }

  hostname = var.identifier

  memory = var.memory

  networks_advanced {
    aliases = var.network_aliases
    name    = var.network_id
  }

  network_mode = "bridge"

  ulimit {
    name = "memlock"
    soft = -1
    hard = -1
  }

  volumes {
    container_path = local.container_data_directory
    host_path      = local.host_data_directory
    read_only      = false
  }

  provisioner "local-exec" {
    command = <<EOT
      chown ${var.data_owner} "${local.host_data_directory}"
    EOT
  }
}
