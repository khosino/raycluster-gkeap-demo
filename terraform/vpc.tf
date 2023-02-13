# VPC
resource "google_compute_network" "vpc_network" {
  name                    = "${var.project_id}-vpc"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

# Subnet1(asia-northeast1)
resource "google_compute_subnetwork" "private1" {
  name          = "subnet-${var.region}"
  ip_cidr_range = "192.168.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

