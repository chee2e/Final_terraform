resource "google_sql_database_instance" "kf_db" {
  name             = "kf-sql-01"
  region           = "asia-northeast3"
  database_version = "MYSQL_8_0"

  settings {
    tier              = "db-f1-micro"
    availability_type = "REGIONAL"

    location_preference {
      zone           = "asia-northeast3-a"
      # secondary_zone = "asia-northeast3-c"
    }

    backup_configuration {
      binary_log_enabled = true
      enabled            = true
    }

    ip_configuration {
      ipv4_enabled    = false
      private_network = data.terraform_remote_state.kf_bucket.outputs.kf_vpc.id
    }
  }
  depends_on          = [google_service_networking_connection.kf_vpc_connection]
  deletion_protection = false
}

# resource "google_sql_user" "users" {
#   name     = "root"
#   instance = google_sql_database_instance.gogle_db.name
#   password = "gogle"
# }

# resource "google_sql_database" "gogle_db" {
#   name     = "shop"
#   instance = google_sql_database_instance.gogle_db.name
# }