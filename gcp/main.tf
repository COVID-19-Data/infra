terraform {
  backend "gcs" {
    bucket  = "tf-api"
    prefix  = "terraform/state"
  }
}

resource "google_cloud_run_service" "strapi" {
  name     = "strapi"
  location = var.gcp_location

  template {
    spec {
      containers {
        image = var.strapi_image
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  metadata {
    annotations = {
      "autoscaling.knative.dev/maxScale"      = "1000"
      "run.googleapis.com/cloudsql-instances" = "${var.project_name}:${var.gcp_location}:${google_sql_database_instance.psql.name}"
    }
  }
}

resource "google_sql_database_instance" "psql" {
  name             = "covid-19-data-postgres"
  database_version = "POSTGRES_11"
  region           = var.gcp_location
  settings {
    tier = var.db_size 
  }
}

