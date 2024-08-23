# KIND :

<p align="center">
<img src="https://github.com/user-attachments/assets/85f324ef-da5c-47d7-b4e4-8dee08c4e450"  width="600" align=center>
</p>

- kind is a tool for running local Kubernetes clusters using Docker container “nodes”.
- kind was primarily designed for testing Kubernetes itself, but may be used for local development or CI.

## Pre-requisite:
<b>[Docker](https://docs.docker.com/get-started/get-docker/)</b>

## [Installation](https://kind.sigs.k8s.io/docs/user/quick-start/#installation):
```
brew install kind
```

## Creating a cluster
1. Create a kind cluster config file:
```
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: control-plane
- role: control-plane
- role: worker
  extraPortMappings:
  - containerPort: 30000
    hostPort: 32001
    listenAddress: "0.0.0.0" # Optional, defaults to "0.0.0.0"
    protocol: tcp # Optional, defaults to tcp
- role: worker
  extraPortMappings:
  - containerPort: 30000
    hostPort: 32002
    listenAddress: "0.0.0.0" # Optional, defaults to "0.0.0.0"
    protocol: tcp # Optional, defaults to tcp
- role: worker
  extraPortMappings:
  - containerPort: 30000
    hostPort: 32003
    listenAddress: "0.0.0.0" # Optional, defaults to "0.0.0.0"
    protocol: tcp # Optional, defaults to tcp
```

2. Start a cluster:
   ```
   kind create cluster --config filename --name clustername
   ```

## Interacting with your cluster
By default, the cluster access configuration is stored in ${HOME}/.kube/config if $KUBECONFIG environment variable is not set.
```
kind get clusters
kubectl config get contexts
kubectl config use-context <context-name>
kubectl get nodes
docker exec -it nodename crictl images
docker exec -it nodename critctl ps
```

## Deleting a cluster
```
kind delete cluster clustername
```

## Loading local image into kind cluster
```
kind load docker-image my-custom-image-0 my-custom-image-1 --name kind-2
```

## Run sample demo application
```
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: hello-kind
  name: hello-kind
spec:
  replicas: 1
  selector:
    matchLabels:
      app: hello-kind
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: hello-kind
    spec:
      containers:
      - image: getting-started:latest
        name: getting-started
        imagePullPolicy: Never
        ports:
        - containerPort: 3000
```


## Create a service for application deployment
```
kubectl expose deployment hello-kind --type=NodePort --port=3000
kubectl get services hello-kind
```
