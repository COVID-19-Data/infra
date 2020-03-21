# infra

## Setup

- terraform version 0.12
- setup credentials by setting env var `GOOGLE_APPLICATION_CREDENTIALS` to the path to your credentials.json file
- run `terraform init` to setup terraform

## Deploy changes

from the `gcp` directory
- run `terraform plan .`
- once you are happy with your plan, run `terraform apply .`

