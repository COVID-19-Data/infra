terraform {
  backend "gcs" {
    bucket  = "tf-api"
    prefix  = "terraform/db_users"
  }
}

provider "google" {
  project     = var.project_name
  region      = var.gcp_location
}

resource "google_sql_user" "andrew_madonna" {
  name     = "andrew_madonna"
  instance = "covid-19-data-instance"
  password = var.andrew_madonna_db_password
}
