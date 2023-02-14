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
GKE Cluster and other resources are created by terraform.
<img width="1423" alt="image" src="https://user-images.githubusercontent.com/111631457/218802716-026480e3-7b95-4526-97d0-4e651ae836b2.png">



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

## 4.Build Docker Image
<!-- #### Follow Tutorial
[Building a Machine Learning Platform with Kubeflow and Ray on Google Kubernetes Engine](https://cloud.google.com/blog/products/ai-machine-learning/build-a-ml-platform-with-kubeflow-and-ray-on-gke)

In this tutorial, [Ray-project/Kuberay](https://github.com/ray-project/kuberay) is used.

### Deploy KubeRay Operator -->
[Use this sample code](https://github.com/horoiwa/deep_reinforcement_learning_gallery/tree/master/DistRL_on_k8s)

Build a Docker image and push to Artifact Registry (Docker Repo in GCP)
```
cd distrl
gcloud builds submit --region=${REGION} --tag ${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPOSITRY_NAME}/sample-image:latest
```
<img width="1406" alt="image" src="https://user-images.githubusercontent.com/111631457/218803578-8a1b070d-8156-4a61-b5a3-ad81ebee52b2.png">


## 5. Deploy pods on GKE
Modify the yaml file to use the container image created in the steps below.
The file new-apex-cluster.yml is used. This command replaces the original apex-cluster.yml image path with the created container image path.
```
sed -e "s@RAY_DOCKER_IMAGE@${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPOSITRY_NAME}/sample-image:latest@g" apex-cluster.yml > new-apex-cluster.yml
```

```
kubectl apply -f new-apex-cluster.yml
kubectl get po
```
<img width="748" alt="image" src="https://user-images.githubusercontent.com/111631457/218805992-6681f55a-4a5e-42c7-b6b8-1deaafecd4ba.png">

## 6. Execute the Ray training
```
kubectl exec -it master bash
```
<img width="914" alt="image" src="https://user-images.githubusercontent.com/111631457/218806440-fcd05470-f4b6-4ab8-b96d-5d63a7557680.png">

Check the status of Ray Cluster
```
ray status
```
<img width="1425" alt="image" src="https://user-images.githubusercontent.com/111631457/218806584-ec579ae3-5095-442d-b165-97c631c60526.png">

Execute the training using 40 actors.
You can change the num_actors as long as your quota allows.
```
python /code/main.py --logdir log/tfboard --cluster --num_actors 40
```
<img width="1214" alt="image" src="https://user-images.githubusercontent.com/111631457/218807108-4b7cee85-58fe-4227-8cbe-16a915158912.png">

You can access the tensorboard with
`https://<EXTERNAL_IP>:6006`
<img width="1417" alt="image" src="https://user-images.githubusercontent.com/111631457/218807831-0a89d69c-0d43-4111-b335-77a5b2651fea.png">


To find EXTERNAL IP
```
kubectl get svc
```

