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

使用 github actions 作為 CICD pipeline  
並設計了四個 workflow  
可分為控制 application, infrastructure的部署  
* application
  * `./.github/workflows/docker-image.yaml`
    * Push main 即包 image, 作為 CI 的一環
  * `./.github/workflows/release.yaml`
    * 透過打 Tag 來控制上線
* infrastructure
  * `./.github/workflows/terraform.yaml`
  * `./.github/workflows/kustomize.yaml`

其中又將 release 與 kustomize 串接, 以達到 workflow 的復用  

## GitOps

透過 github actions 或其他種類的 CICD 工具來達到 GitOps 的效果
基本上 GitOps 的概念為以 git 作為版本控制與表達各環境的真實情況來設計

以目前這份作業來說
kusomize 的 overlay 可以直接產出各環境的設定檔
但 terraform 則需要把目前的 code 包成 module, 並分成各環境的 tf 檔會比較好控制
另外 terraform 也有 workspace 的概念, 可以用來區分不同環境, 但官方並不建議使用(除非你用他們的 terraform cloud)
如果以目前的情況要做 GitOps 我會建議把 terraform 和 kustomize 拆出去會比較好
不然同一個 repo 要處理這麼多的 flow 會很不好寫 CICD

## terraform 與 Helm chart

兩者可透過 terraform 來共同管理
[Helm terraform](https://registry.terraform.io/providers/hashicorp/helm/latest/docs)

或用 `terraform output -json` 來提取 output 後再透過其他自動化工具讀取復用
