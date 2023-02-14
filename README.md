# Ray Cluster on GKE Autopilot 

Hands-on tutorial of Ray on Google Kubernetes Engine Autopilot
## 0. Clone resouces
#### Prepare resources

```
$mkdir ray-cluster-demo; cd $_
$git clone https://github.com/khosino/raycluster-gkeap-demo.git
$git clone https://github.com/ray-project/kuberay.git
```
KubeRay is an open source toolkit to run Ray applications on Kubernetes. It provides several tools to simplify managing Ray clusters on Kubernetes.


## 1. Setup Google Cloud Storage for terraform state
#### Prepare the Storage to store tfstate file

enable APIs
```
gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable iam.googleapis.com
gcloud services enable compute.googleapis.com
gcloud services enable serviceusage.googleapis.com
gcloud services enable container.googleapis.com
gcloud services enable pubsub.googleapis.com
gcloud services enable storage-component.googleapis.com
gcloud services enable artifactregistry.googleapis.com
gcloud services enable cloudbuild.googleapis.com
```

set environment variable from `.env`.
```
$cd raycluster-gkeap-demo
$vi .env
PROJECT_ID="{YOUR PROJECT ID}"
REGION="asia-northeast1"
ZONE="asia-northeast1-a"
```

```
$source .env
```

Create Google Cloud Storage Bucket

```
$gsutil mb -l $REGION gs://$PROJECT_ID-terraform-state
```

## 2. Setup Google Cloud Resources
#### Execute terraform command to setup GPC Infra

Apply terraform 

```
$cd terraform
$terraform init
$terraform apply -var=project_id=$PROJECT_ID -var=region=$REGION -var=zone=$ZONE -var=cluster_name=$CLUSTER_NAME -var=repo_name=$REPOSITRY_NAME
```
<br>

## 3. Setup Ray Cluster on Kubernetes
#### Execute kubectl command to setup Ray Cluster
set credentials to use kubectl to GKE Cluster
```
$gcloud container clusters get-credentials $CLUSTER_NAME --region=$REGION
```
test the kubectl command
```
$kubectl get node
```

## 4. Deploy Pods
<!-- #### Follow Tutorial
[Building a Machine Learning Platform with Kubeflow and Ray on Google Kubernetes Engine](https://cloud.google.com/blog/products/ai-machine-learning/build-a-ml-platform-with-kubeflow-and-ray-on-gke)

In this tutorial, [Ray-project/Kuberay](https://github.com/ray-project/kuberay) is used.

### Deploy KubeRay Operator -->
[Use this sample code](https://github.com/horoiwa/deep_reinforcement_learning_gallery/tree/master/DistRL_on_k8s)





