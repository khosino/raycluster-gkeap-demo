resource "google_service_account" "gke_sa" {
    project      = data.google_project.project.project_id
    account_id   = var.gke_sa_name
    display_name = "GKE Service Account"
}

resource "google_project_iam_member" "gke_sa_role_bindings" {
    project  = data.google_project.project.project_id
    for_each = toset(var.gke_sa_roles)
    member   = "serviceAccount:${google_service_account.gke_sa.email}"
    role     = "roles/${each.value}"
}

resource "google_service_account_iam_binding" "workload_identity" {
  service_account_id = google_service_account.gke_sa.name
  role               = "roles/iam.workloadIdentityUser"
  members = [
    "serviceAccount:${var.project_id}.svc.id.goog[default/ray-worker-sa]"
  ]
}

data "google_compute_default_service_account" "default" {
}

resource "google_project_iam_member" "default_sa_role_bindings" {
    project  = data.google_project.project.project_id
    for_each = toset(var.default_sa_roles)
    member   = "serviceAccount:${data.google_compute_default_service_account.default.email}"
    role     = "roles/${each.value}"
}