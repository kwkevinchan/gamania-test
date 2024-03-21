data "google_container_engine_versions" "asia_east1_gke_version" {
  project = "gamania-test-417905"
  location       = "asia-east1"
  provider       = google-beta
  version_prefix = "1.27."
}
