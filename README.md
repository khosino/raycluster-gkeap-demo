#Ray Cluster on GKE Autopilot 

Hands-on tutorial of Ray on Google Kubernetes Engine Autopilot


## 1. Setup GCP resources

`code/` is simple implmentation of Ape-X for `CartPole-v1` env.

```
#: Run on local machine
pip install -f requirements.txt
python main.py --num-actors=4 --logdir=log
```

<br>

## 2. Setup

#### Install Cloud SDK, docker, kubectl on your local machine

