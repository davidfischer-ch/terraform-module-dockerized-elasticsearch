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
  default     = true
  description = "Toggle the containers (started or stopped)."
}

variable "wait" {
  type        = bool
  default     = true
  description = "Wait for the container to reach an healthy state after creation."
}

variable "image_id" {
  type        = string
  description = "Elasticsearch image's ID."
}

# Process ------------------------------------------------------------------------------------------

variable "app_uid" {
  type        = number
  default     = 1000
  description = "UID of the user running the container and owning the data directories."
}

variable "app_gid" {
  type        = number
  default     = 1000
  description = "GID of the user running the container and owning the data directories."
}

variable "privileged" {
  type        = bool
  default     = false
  description = "Run the container in privileged mode."
}

variable "cap_add" {
  type        = set(string)
  default     = []
  description = "Linux capabilities to add to the container."
}

variable "cap_drop" {
  type        = set(string)
  default     = []
  description = "Linux capabilities to drop from the container."
}

# Storage ------------------------------------------------------------------------------------------

variable "data_directory" {
  type        = string
  description = "Where data will be persisted (volumes will be mounted as sub-directories)."
}

# Configuration ------------------------------------------------------------------------------------

variable "env" {
  type        = map(string)
  default     = {}
  description = "Define or overwrite environment variables for configuring the instance."
}

# Resources ----------------------------------------------------------------------------------------

variable "memory" {
  type        = number
  description = "The memory limit for the container in MBs."
}

# Networking ---------------------------------------------------------------------------------------

variable "hosts" {
  type        = map(string)
  default     = {}
  description = "Add entries to container hosts file."
}

variable "network_aliases" {
  type        = set(string)
  default     = []
  description = "Network aliases of the container in the specific network"
}

variable "network_id" {
  type        = string
  description = "Attach the containers to given network."
}

variable "port" {
  type    = number
  default = 9200

  validation {
    condition     = var.port == 9200
    error_message = "Having `port` different than 9200 is not yet implemented."
  }
}
