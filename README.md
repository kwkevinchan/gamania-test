# Gamania Test

## Terraform

建立 GKE Cluster

* terraform infrastructure: `terraform/providers.tf`
  * provider: `google`
  * backend: `gcs`
    * state bucket: `tf-state-gamania-test-417905`
* teraform main
* terraform variables
  * `terraform/variables.tf`
  * `terraform/terraform.tfvars`

## Neigx Docker

* Dockerfile: `nginx/Dockerfile`
* nginx config: `nginx/nginx.conf`
* static files: `nginx/static/`

## Helm Chart

## CI/CD Pipeline
