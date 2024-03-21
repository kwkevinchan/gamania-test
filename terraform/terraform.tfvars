gke_cluster = {
  name = "gamania-test-cluster"
  subnetwork_index = 0
}

default_node_pools = [
  {
    name               = "gamania-test-pool"
    machine_type       = "e2-medium"
    default_node_count = 1
    disk_size_gb       = 10
  },
]
