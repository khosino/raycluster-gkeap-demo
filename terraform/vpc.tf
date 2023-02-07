# VPC
resource "google_compute_network" "vpc_network" {
  name                    = "btc4043-vpc"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

# Subnet1(asia-northeast1)
resource "google_compute_subnetwork" "an1_private1" {
  name          = "btc4043-an1-private1"
  ip_cidr_range = "192.168.1.0/24"
  region        = "asia-northeast1"
  network       = google_compute_network.vpc_network.id
}

