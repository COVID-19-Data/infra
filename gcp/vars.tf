variable "db_size" {
    type = string
    default = "db-f1-micro"
}

variable "gcp_location" {
    type = string
    default = "europe-west4"
}

variable "project_location" {
  type = string
  default = "eu.gcr.io"
}

variable "project_name" {
  type = string
  default = "covid-19-data-271621"
}

variable "strapi_image" {
    type = string
    default = "strapi:latest"
}

variable "strapi_user_db_password" {
  type = string
}
