resource "google_container_cluster" "kf_gke" {
  project = "class-mino-01"
  provider                 = google-beta
  name                     = "kf-cluster-01"
  location                 = "asia-northeast3"
  remove_default_node_pool = true
  initial_node_count       = 1

#   pod_ipv4_cidr_block = "10.200.0.0/16"

  network    = google_compute_network.kf_vpc.name
  subnetwork = google_compute_subnetwork.kf_subnet.name

  ip_allocation_policy {
      services_ipv4_cidr_block = "10.100.0.0/16"
      cluster_ipv4_cidr_block = "10.200.0.0/16"
  }

  addons_config {
    horizontal_pod_autoscaling {
      disabled = false # Default = false
    }
    http_load_balancing {
      disabled = false # Default = false
    }
  }

  logging_service = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "10.0.0.200/32"
      display_name = "kf-bastion"
    }
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = true
    master_ipv4_cidr_block  = "10.10.0.0/28"

    master_global_access_config {
      enabled = false
    }
  }

  workload_identity_config {
  workload_pool = "class-mino-01.svc.id.goog" 
  }

  lifecycle {ignore_changes = all}
}

output "kf_gke" {
  value = google_container_cluster.kf_gke
  sensitive = true
}