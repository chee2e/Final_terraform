resource "google_compute_instance" "bastion" {
  name         = "kf-bastion-01"
  machine_type = "e2-medium"
  zone         = "asia-northeast3-a"

  tags = ["bastion"]

  boot_disk {
    initialize_params {
      image = "rocky-linux-cloud/rocky-linux-8-optimized-gcp"
    }
  }

  network_interface {
    network    = data.terraform_remote_state.kf_bucket.outputs.kf_vpc.id
    subnetwork = data.terraform_remote_state.kf_bucket.outputs.kf_subnet.id

    network_ip = "10.0.0.200"

    access_config {
      # nat_ip = google_compute_global_address.bastion_ip.address
    }
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "bastion-account@class-mino-01.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }

  metadata_startup_script = data.template_file.startup_script.rendered
  #depends_on              = [google_container_cluster.primary]

}