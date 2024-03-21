variable "region" {
  description = "region name"
  type        = string
  default     = "asia-east1"
}

variable "vpc" {
  type = object({
    name = string
    subnets = list(object({
      name          = string
      ip_cidr_range = string
    }))
  })
  default = {
    name = "vpc-network"
    subnets = [{
      name          = "vpc-subnet"
      ip_cidr_range = "10.1.0.0/16"
    }]
  }
  description = "The VPC setting"
}

variable "gke_cluster" {
  description = "The GKE cluster name"
  type = object({
    name = string
    subnetwork_index = number
  })
  default = {
    name = "gke-cluster"
    subnetwork_index = 0
  }
}

# gke node pool
variable "default_node_pools" {
  type = list(object({
    name               = string
    machine_type       = string
    default_node_count = number
    disk_size_gb       = number
  }))
  default = [{
    name               = "default-pool"
    machine_type       = "e2-medium"
    default_node_count = 1
    disk_size_gb       = 20
  }]
  description = "node pool configuration"
}

# acr
variable "acr" {
  type = object({
    repository_id = string
  })
  default = {
    repository_id = "gke-repository"
  }
  description = "The Artifact Registry setting"
}