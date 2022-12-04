resource "google_compute_firewall" "ssh" {
  project     = "class-mino-01"
  name        = "kf-allow-ssh"
  network     = data.terraform_remote_state.kf_bucket.outputs.kf_vpc.id
  description = "Creates firewall rule targeting tagged instances"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags   = ["bastion"]
  source_ranges = ["35.235.240.0/20"]
}

# resource "google_compute_firewall" "jenkins" {
#   project     = "class-mino-01"
#   name        = "gogle-vpc-allow-jenkins"
#   network     = google_compute_network.gogle_vpc.id
#   description = "Creates firewall rule targeting tagged instances"

#   allow {
#     protocol = "tcp"
#     ports    = ["8080"]
#   }

#   target_tags   = ["jenkins"]
#   source_ranges = ["0.0.0.0/0"]
# }

# resource "google_compute_firewall" "web" {
#   project     = "class-mino-01"
#   name        = "tf-vpc-allow-web"
#   network     = google_compute_network.tf_vpc.id
#   description = "Creates firewall rule targeting tagged instances"

#   allow {
#     protocol = "tcp"
#     ports    = ["80", "8080"]
#   }

#   target_tags   = ["web-server"]
#   source_ranges = ["0.0.0.0/0"]
# }


# resource "google_compute_firewall" "mig" {
#   project     = "class-mino-01"
#   name        = "tf-vpc-allow-web-mig"
#   network     = google_compute_network.tf_vpc.id
#   description = "Creates firewall rule targeting tagged instances"

#   allow {
#     protocol = "tcp"
#     ports    = ["80"]
#   }

#   target_tags   = ["web-mig"]
#   source_ranges = ["35.191.0.0/16", "130.211.0.0/22"]
# }