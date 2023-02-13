resource "google_artifact_registry_repository" "my-repo" {
  location      = "asia-northeast1"
  repository_id = var.repo_name
  description   = "ray docker image repository"
  format        = "DOCKER"
}