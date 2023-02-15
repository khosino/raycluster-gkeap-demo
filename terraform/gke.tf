# GKE cluster(Autopilot)
resource "google_container_cluster" "gkeap" {
  name     = var.cluster_name

  enable_autopilot = true
  location = "asia-northeast1"

  release_channel {
    channel = "REGULAR"
  }
  min_master_version = "1.24.8-gke.2000"

  networking_mode = "VPC_NATIVE"
  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "10.10.0.0/16"
    services_ipv4_cidr_block = "10.20.0.0/16"
  }

  network    = google_compute_network.vpc_network.self_link
  subnetwork = google_compute_subnetwork.private1.self_link

  vertical_pod_autoscaling {
    enabled = true
  }

#   node_config {
#     service_account = google_service_account.gke_sa.email
#     oauth_scopes = [
#       "https://www.googleapis.com/auth/cloud-platform"
#     ]
#   }


  master_authorized_networks_config {
  }

  maintenance_policy {
    recurring_window {
      start_time = "2022-04-29T17:00:00Z"
      end_time   = "2022-04-29T21:00:00Z"
      recurrence = "FREQ=WEEKLY;BYDAY=FR,SA,SU"
    }
  }

}