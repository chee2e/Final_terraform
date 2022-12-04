resource "google_container_node_pool" "app_nodes" {
  provider           = google-beta
  name_prefix        = "app-pool"
  cluster            = data.terraform_remote_state.kf_bucket.outputs.kf_gke.id
  initial_node_count = 1
  

  node_locations = ["asia-northeast3-b", "asia-northeast3-c"]


  node_config {
    machine_type = "e2-medium"

    labels = {
      "node" = "app"
    }

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    oauth_scopes    = ["cloud-platform"]
  }

  autoscaling {
    min_node_count  = 2
    max_node_count  = 5
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}
