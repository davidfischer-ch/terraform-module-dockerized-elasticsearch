resource "docker_image" "elasticsearch" {
  name         = "elasticsearch:8.15.4"
  keep_locally = true
}

resource "docker_network" "app" {
  name   = "my-app"
  driver = "bridge"
}

module "elasticsearch" {
  source = "git::https://github.com/davidfischer-ch/terraform-module-dockerized-elasticsearch.git?ref=1.2.0"

  identifier = "my-app-search"
  image_id   = docker_image.elasticsearch.image_id

  # Resources

  memory = 4096

  # Networking

  network_id      = docker_network.app.id
  network_aliases = ["elasticsearch"]

  # Storage

  data_directory = "/data/my-app/search"

  # Configuration

  env = {
    "discovery.type"         = "single-node"
    "bootstrap.memory_lock"  = "true"
    "xpack.security.enabled" = "false"
    "ES_JAVA_OPTS"           = "-Xms2g -Xmx2g"
  }
}
