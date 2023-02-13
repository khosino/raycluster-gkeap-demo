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