# infra

## Setup

- terraform version 0.12
- setup credentials by setting env var `GOOGLE_APPLICATION_CREDENTIALS` to the path to your credentials.json file
- run `terraform init` to setup terraform

## Deploy changes

- set `strapi_user_db_password` and `metadata_user_db_password` by setting env var `TF_VAR_strapi_user_db_password` and `TF_VAR_metadata_user_db_password` respectively to the desired password

from the `gcp` directory
- run `terraform plan .`
- once you are happy with your plan, run `terraform apply .`

