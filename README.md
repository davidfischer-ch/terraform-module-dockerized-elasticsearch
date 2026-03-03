# Elasticsearch Terraform Module (Dockerized)

Manage Elasticsearch server.

* Runs in bridge networking mode
* Persists data directory
* Configurable memory limit and network aliases
* Sets `memlock` ulimit for stable performance

## Usage

```hcl
module "elasticsearch" {
  source = "git::https://github.com/davidfischer-ch/terraform-module-dockerized-elasticsearch.git?ref=1.0.0"

  identifier     = "my-app-search"
  enabled        = true
  image_id       = docker_image.elasticsearch.image_id
  data_directory = "/data/my-app/search"

  memory = 4096

  env = {
    "discovery.type"         = "single-node"
    "bootstrap.memory_lock"  = "true"
    "xpack.security.enabled" = "false"
    "ES_JAVA_OPTS"           = "-Xms2g -Xmx2g"
  }

  hosts           = module.fisch3r_net.lan_hosts
  network_id      = docker_network.app.id
  network_aliases = ["elasticsearch"]
}
```

## Data layout

All persistent data lives under `data_directory`:

```
data_directory/
└── data/  # Elasticsearch data files
```

## Variables

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `identifier` | `string` | — | Unique name for resources (must match `^[a-z]+(-[a-z0-9]+)*$`). |
| `enabled` | `bool` | — | Start or stop the container. |
| `wait` | `bool` | `false` | Wait for the container to reach a healthy state after creation. |
| `image_id` | `string` | — | [Elasticsearch](https://hub.docker.com/_/elasticsearch/tags) Docker image's ID. |
| `data_directory` | `string` | — | Host path for persistent volumes. |
| `data_owner` | `string` | `"1000:1000"` | UID:GID for data directories. |
| `env` | `map(string)` | `{}` | Environment variables for configuring the instance. |
| `memory` | `number` | — | Memory limit for the container in MBs. |
| `hosts` | `map(string)` | `{}` | Extra `/etc/hosts` entries for the container. |
| `network_aliases` | `set(string)` | `[]` | Network aliases for the container. |
| `network_id` | `string` | — | Docker network to attach to. |
| `port` | `number` | `9200` | Elasticsearch port (changing not yet implemented). |

## Outputs

| Name | Description |
|------|-------------|
| `host` | Container hostname. |
| `port` | Elasticsearch port. |

## Requirements

* Terraform >= 1.6
* [kreuzwerker/docker](https://github.com/kreuzwerker/terraform-provider-docker) >= 3.0.2

## References

* https://hub.docker.com/_/elasticsearch
* https://github.com/davidfischer-ch/ansible-role-elasticsearch
