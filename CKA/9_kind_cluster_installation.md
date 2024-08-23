# KIND : 
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
# three node (two workers) cluster config
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: control-plane
- role: control-plane
- role: worker
- role: worker
- role: worker
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
