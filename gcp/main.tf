terraform {
  backend "gcs" {
    bucket  = "tf-api"
    prefix  = "terraform/state"
  }
}

provider "google" {
  project     = var.project_name
  region      = var.gcp_location
}

resource "google_cloud_run_service" "strapi" {
  name     = "strapi"
  location = var.gcp_location

  template {
    spec {
      containers {
        image = "${var.project_location}/${var.project_name}/${var.strapi_image}"
        env {
          name  = "DATABASE_NAME"
          value = google_sql_database.metadata_store.name
        }
        env {
          name  = "DATABASE_USERNAME"
          value = google_sql_user.strapi_user.name
        }
        env {
          name  = "DATABASE_PASSWORD"
          value = var.strapi_user_db_password
        }
        env {
          name  = "DATABASE_SOCKET_PATH"
          value = "/cloudsql/${var.project_name}:${var.gcp_location}:${google_sql_database_instance.metadata_store.name}"
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  metadata {
    annotations = {
      "autoscaling.knative.dev/maxScale"      = "100"
      "run.googleapis.com/cloudsql-instances" = "${var.project_name}:${var.gcp_location}:${google_sql_database_instance.metadata_store.name}"
      "run.googleapis.com/client-name"        = "cloud-console"
    }
  }
}

resource "google_sql_database" "metadata_store" {
  name     = "covid-19-data"
  instance = google_sql_database_instance.metadata_store.name
}

resource "google_sql_database_instance" "metadata_store" {
  name             = "covid-19-data-instance"
  database_version = "POSTGRES_11"
  region           = var.gcp_location
  settings {
    tier = var.db_size
  }
}

resource "google_sql_user" "strapi_user" {
  name     = "strapi_user"
  instance = google_sql_database_instance.metadata_store.name
  password = var.strapi_user_db_password
}
