resource "google_compute_global_address" "db_address" {
  name          = "kf-sql-address-01"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  address       = "10.20.0.0"
  prefix_length = 16
  network       = data.terraform_remote_state.kf_bucket.outputs.kf_vpc.id
}

resource "google_service_networking_connection" "kf_vpc_connection" {
  network                 = data.terraform_remote_state.kf_bucket.outputs.kf_vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.db_address.name]
}