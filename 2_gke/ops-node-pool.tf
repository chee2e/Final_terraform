resource "google_container_node_pool" "ops_nodes" {
  provider           = google-beta
  name_prefix        = "ops-pool"
  cluster            = data.terraform_remote_state.kf_bucket.outputs.kf_gke.id
  initial_node_count = 1

  node_locations = ["asia-northeast3-a"]

  node_config {
    machine_type = "e2-medium"

    labels = {
      "node" = "ops"
    }

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    # service_account = "gke-access-account@class-mino-01.iam.gserviceaccount.com"
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