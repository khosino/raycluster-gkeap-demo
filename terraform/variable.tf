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

variable "bigquery_dataset" {
    description = "The BigQuery Dataset Name"
    type        = string
}


