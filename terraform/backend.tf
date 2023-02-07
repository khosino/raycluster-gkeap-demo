terraform {
 backend "gcs" {
   bucket  = "raycluster-demo-terraform-state"
   prefix  = "terraform/state"
 }
}