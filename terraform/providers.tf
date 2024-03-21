terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }

  # GCS backend
  backend "gcs" {
    bucket = "tf-state-gamania-test-417905"
    prefix = "terraform/state"
  }
}

# GCP setting
provider "google" {
  project = "gamania-test-417905"
  region  = "asia-east1"
}

# GCS bucket
resource "google_storage_bucket" "tf-state" {
  name     = "tf-state-gamania-test-417905"
  location = "ASIA"
}
