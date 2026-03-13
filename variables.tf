variable "identifier" {
  type        = string
  description = "Identifier (must be unique, used to name resources)."

  validation {
    condition     = regex("^[a-z]+(-[a-z0-9]+)*$", var.identifier) != null
    error_message = "Argument `identifier` must match regex ^[a-z]+(-[a-z0-9]+)*$."
  }
}

variable "enabled" {
  type        = bool
  description = "Toggle the containers (started or stopped)."
  default     = true
}

variable "wait" {
  type        = bool
  description = "Wait for the container to reach an healthy state after creation."
  default     = true
}

variable "image_id" {
  type        = string
  description = "Elasticsearch image's ID."
}

# Process ------------------------------------------------------------------------------------------

variable "app_uid" {
  type        = number
  description = "UID of the user running the container and owning the data directories."
  default     = 1000
}

variable "app_gid" {
  type        = number
  description = "GID of the user running the container and owning the data directories."
  default     = 1000
}

variable "privileged" {
  type        = bool
  description = "Run the container in privileged mode."
  default     = false
}

variable "cap_add" {
  type        = set(string)
  description = "Linux capabilities to add to the container."
  default     = []
}

variable "cap_drop" {
  type        = set(string)
  description = "Linux capabilities to drop from the container."
  default     = []
}

# Storage ------------------------------------------------------------------------------------------

variable "data_directory" {
  type        = string
  description = "Where data will be persisted (volumes will be mounted as sub-directories)."
}

# Configuration ------------------------------------------------------------------------------------

variable "env" {
  type        = map(string)
  description = "Define or overwrite environment variables for configuring the instance."
  default     = {}
}

# Resources ----------------------------------------------------------------------------------------

variable "memory" {
  type        = number
  description = "The memory limit for the container in MBs."

  validation {
    condition     = var.memory >= 512
    error_message = "Argument `memory` must be at least 512 (MB)."
  }
}

# Networking ---------------------------------------------------------------------------------------

variable "hosts" {
  type        = map(string)
  description = "Add entries to container hosts file."
  default     = {}
}

variable "network_aliases" {
  type        = set(string)
  description = "Network aliases of the container in the specific network"
  default     = []
}

variable "network_id" {
  type        = string
  description = "Attach the containers to given network."
}

variable "port" {
  type        = number
  description = "Bind the Elasticsearch HTTP port."
  default     = 9200

  validation {
    condition     = var.port == 9200
    error_message = "Having `port` different than 9200 is not yet implemented."
  }
}
