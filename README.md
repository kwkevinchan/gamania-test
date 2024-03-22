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

### cheat sheet

```bash
terraform init
terraform plan
terraform apply -auto-approve
terraform destroy -auto-approve
```

## Neigx Docker

* Dockerfile: `nginx/Dockerfile`
* nginx config: `nginx/nginx.conf`
* static files: `nginx/static/`

### cheat sheet

```bash
docker build -t gamania-test-nginx:latest -f ./docker/nginx/Dockerfile .
docker run -d -p 8080:80 gamania-test-nginx:latest

gcloud auth configure-docker asia-east1-docker.pkg.dev
gcloud auth print-access-token | docker login -u oauth2accesstoken --password-stdin https://asia-east1-docker.pkg.dev
docker tag gamania-test-nginx:latest asia-east1-docker.pkg.dev/gamania-test-417905/gke-repository/nginx:v1
docker push asia-east1-docker.pkg.dev/gamania-test-417905/gke-repository/nginx:v1
```

## Kustomize

* kustomize: `kustomize/`
  * base: `kustomize/base/`
  * overlays: `kustomize/overlays/`

### cheat sheet

```bash
gcloud container clusters get-credentials gamania-test-cluster --region asia-east1
kubectl apply -k kustomize/overlays/prod/
```

## CI/CD Pipeline

