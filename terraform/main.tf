terraform {
  required_version = ">=1.7"
}

# VPC
resource "google_compute_network" "vpc" {
  name = var.vpc.name
}

# AZ
resource "google_compute_subnetwork" "vpc_subnets" {
  count         = length(var.vpc.subnets)
  name          = var.vpc.subnets[count.index].name
  ip_cidr_range = var.vpc.subnets[count.index].ip_cidr_range
  network       = google_compute_network.vpc.id
  region        = var.region
}

# GKE
resource "google_container_cluster" "gke_main" {
  name                     = var.gke_cluster.name
  location                 = "asia-east1"
  network                  = google_compute_network.vpc.id
  subnetwork               = google_compute_subnetwork.vpc_subnets[var.gke_cluster.subnetwork_index].id
  node_version            = data.google_container_engine_versions.asia_east1_gke_version.latest_master_version
  remove_default_node_pool = true
  initial_node_count       = 1

  lifecycle {
    ignore_changes = [node_version]
  }
}

# GKE node pool
resource "google_container_node_pool" "gke_node_pool" {
  count      = length(var.default_node_pools)
  name       = var.default_node_pools[count.index].name
  location   = "asia-east1"
  cluster    = google_container_cluster.gke_main.name
  node_count = var.default_node_pools[count.index].default_node_count
  node_config {
    machine_type = var.default_node_pools[count.index].machine_type
    disk_size_gb = var.default_node_pools[count.index].disk_size_gb
  }
}
