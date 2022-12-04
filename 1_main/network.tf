resource "google_compute_network" "kf_vpc" {
  project                 = "class-mino-01"
  name                    = "kf-vpc-01"
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "kf_subnet" {
  name          = "kf-subnet-01"
  ip_cidr_range = "10.0.0.0/16"
  region        = "asia-northeast3"
  network       = google_compute_network.kf_vpc.id
}

resource "google_compute_router" "kf_router" {
  name    = "kf-router-01"
  region  = google_compute_subnetwork.kf_subnet.region
  network = google_compute_network.kf_vpc.id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "kf_nat" {
  name                               = "kf-nat-01"
  router                             = google_compute_router.kf_router.name
  region                             = google_compute_router.kf_router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}


output "kf_vpc" {
  value = google_compute_network.kf_vpc
}

output "kf_subnet" {
  value = google_compute_subnetwork.kf_subnet
}