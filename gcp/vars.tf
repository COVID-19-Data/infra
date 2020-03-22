variable "db_size" {
    type = string
    default = "db-f1-micro" 
}

variable "gcp_location" {
    type = string
    default = "europe-west4"
}

variable "project_name" {
  type = string
  default = "covid-19-data-271621" 
}

variable "strapi_image" {
    type = string
    default = "eu.gcr.io/${var.project_name}/strapi:latest"
}

variable "strapi_user_db_password" {
  type = string
}
