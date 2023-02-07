# Ray Cluster on GKE Autopilot 

Hands-on tutorial of Ray on Google Kubernetes Engine Autopilot


## 1. Setup Google Cloud Storage for terraform state



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

<br>

## 2. Setup

#### Install Cloud SDK, docker, kubectl on your local machine

