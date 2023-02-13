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
$terraform apply -var=project_id=$PROJECT_ID -var=region=$REGION -var=zone=$ZONE -var=cluster_name=$CLUSTER_NAME
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

## 4. Deploy Kuberay
#### Follow Kuberay github
[https://github.com/ray-project/kuberay.git](https://github.com/ray-project/kuberay/tree/master/ray-operator)

```
$cd ..
$kubectl create -k kuberay/ray-operator/config/default
```
Check
```
$kubectl get deployments -n ray-system
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
kuberay-operator   1/1     1            1           2m35s

$kubectl get pods -n ray-system
NAME                                READY   STATUS    RESTARTS   AGE
kuberay-operator-68c7b998b8-4pf62   1/1     Running   0          2m49s
```
Deploy sample code
```
kubectl create -f kuberay/ray-operator/config/samples/ray-cluster.heterogeneous.yaml
```
