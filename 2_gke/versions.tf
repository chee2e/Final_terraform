provider "google" {
  region  = "asia-northeast3" #Asia Pacific (Seoul Region)
  version = "~> 4.0"
}

data "terraform_remote_state" "kf_bucket" {
  backend = "gcs"
  config = {
    bucket = "kf-tfstate-01"
    prefix = "terraform/state"
  }
}

