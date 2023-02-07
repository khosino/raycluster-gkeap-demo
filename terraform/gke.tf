# GKE cluster(Autopilot)
resource "google_container_cluster" "gkeap" {
  name     = "btc4043-gke2-cluster"

  enable_autopilot = true
  location = "asia-northeast1"

  release_channel {
    channel = "STABLE"
  }

  networking_mode = "VPC_NATIVE"
  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "10.10.0.0/16"
    services_ipv4_cidr_block = "10.20.0.0/16"
  }

  network    = google_compute_network.vpc_network.self_link
  subnetwork = google_compute_subnetwork.an1_private1.self_link

  private_cluster_config {
    enable_private_nodes = true
    enable_private_endpoint = true
    master_ipv4_cidr_block = "192.168.100.0/28"

    master_global_access_config {
    enabled = false
    }
  }

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