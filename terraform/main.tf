terraform {
  required_version = ">= 0.14"
  required_providers {
    google = "~> 4.15"
  }
#    backend "gcs" {
#    bucket  = "PROJECT_ID-tf-state"
#    prefix  = "af-demo"
#  }
}

provider "google" {
    project = var.project_id 
    region  = var.region
}

provider "google-beta" {
  project = var.project_id
}

data "google_project" "project" {
    project_id = var.project_id    
}
