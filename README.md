# Ray Cluster on GKE Autopilot 

Hands-on tutorial of Ray on Google Kubernetes Engine Autopilot


## 1. Setup Google Cloud Storage for terraform state
#### Prepare the Storage to store tfstate file

set environment variable from `.env`.
```
vi .env
```

```
PROJECT_ID="{YOUR PROJECT ID}"
REGION="asia-northeast1"
ZONE="asia-northeast1-a"
```

```
source .env
```

Create Google Cloud Storage Bucket

```
gsutil mb -l $REGION gs://$PROJECT_ID-terraform-state
```

## 2. Setup Google Cloud Resources
#### Execute terraform command to setup GPC Infra

Apply terraform 

```
cd terraform
terraform init
terraform apply -var=project_id=$PROJECT_ID -var=region=$REGION -var=zone=$ZONE -var=cluster_name=$CLUSTER_NAME
```
<br>

## 3. Setup Ray Cluster on Kubernetes
#### Execute kubectl command to setup Ray Cluster
set credentials to use kubectl to GKE Cluster
```
gcloud container clusters get-credentials $CLUSTER_NAME --region=$REGION
```
