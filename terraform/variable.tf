variable "project_id" {
    description = "The GCP project ID"
    type        = string
}

variable "region" {
    description = "The region for the environment resources"
    type        = string
}

variable "zone" {
    description = "The zone for a Vertex Notebook instance"
    type        = string
}

variable "cluster_name" {
    description = "The GKE Cluster name"
    type        = string
}

variable "repo_name" {
    description = "The Repositry name"
    type        = string
}

variable "gke_sa_roles" {
  description = "The roles to assign to the GKE service acount"
  default = [
    "editor"
  ]
}

variable "default_sa_roles" {
  description = "The roles to assign to the Default service acount"
  default = [
    "editor"
  ]
}

variable "gke_sa_name" {
    description = "The Repositry name"
    default = "gke-sa"
}