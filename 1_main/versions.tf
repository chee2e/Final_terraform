provider "google" {
  project = "class-mino-01"
  region  = "asia-northeast3" #Asia Pacific (Seoul Region)
  version = "~> 4.0"
}

resource "google_storage_bucket" "kf_bucket" {
  name          = "kf-tfstate-01"
  force_destroy = false
  location      = "asia"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}

terraform {
  backend "gcs" {
    bucket = "kf-tfstate-01"
    prefix = "terraform/state"
  }
}
