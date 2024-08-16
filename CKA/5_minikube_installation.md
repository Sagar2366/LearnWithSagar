
# minikube installation guide
minikube is local Kubernetes, focusing on making it easy to learn and develop for Kubernetes.

All you need is Docker (or similarly compatible) container or a Virtual Machine environment, and Kubernetes is a single command away: ```minikube start```

What you’ll need
```
2 CPUs or more
2GB of free memory
20GB of free disk space
Internet connection
Container or virtual machine manager, such as: Docker, QEMU, Hyperkit, Hyper-V, KVM, Parallels, Podman, VirtualBox, or VMware Fusion/Workstation
```

## Steps 
1. Setup suitable [supported driver](https://minikube.sigs.k8s.io/docs/drivers/)<br>
   - For example,
   [Docker](https://docs.docker.com/guides/getting-started/get-docker-desktop/): The Docker driver allows you to install Kubernetes into an existing Docker install.

2. Install kubectl:
   - Follow the instruction for Linux, Mac, Windows to install kubectl: https://kubernetes.io/docs/tasks/tools/#kubectl

3. Install minikube:
   - Go to https://minikube.sigs.k8s.io/docs/start/
   - Click on the buttons that describe your target platform and select the instructions

4. Ensure you have latest version of minikube
   ```
   minikube update-check
   ```
   
5. Start multinode minikube cluster with Kubernetes version v1.31.0:
   ```
   minikube start \
    --driver=docker \
    --nodes 3 \
    --cni calico \
    --cpus=2 \
    --memory=2g \
    --kubernetes-version=v1.31.0 \
    --container-runtime=containerd \
    --profile minikube-k8s-v1-31-0
   ```

   Here’s a breakdown of the command:

- --driver=docker: Specifies docker as the driver.
- --nodes 3: Creates a 3-node cluster.
- --cni calico: Uses Calico for the Container Network Interface.
- --cpus=2: Allocates 2 CPUs to each node.
- --memory=2g: Allocates 2GB of RAM to each node.
- --kubernetes-version=v1.31.0: Specifies Kubernetes version 1.31.0.
- --container-runtime=containerd: Uses containerd as the container runtime.
- --profile=minikube-k8s-v1-31-0: Give each cluster a unique name (to avoid disturbing other minikube clusters if you have any)

  
6.  Interact with your cluster:
```
  kubectl get nodes -A
  minikube kubectl -- get pods -A
```

7.  Start minikube dashboard: ``` minikube dashboard ```

8.  Deploy sample application
    ```kubectl create deployment hello-minikube --image=kicbase/echo-server:1.0
kubectl expose deployment hello-minikube --type=NodePort --port=8080
kubectl get services hello-minikube
minikube service hello-minikube or kubectl port-forward service/hello-minikube 7080:8080
    ```
9.  Pushing local images inside minikube: https://minikube.sigs.k8s.io/docs/handbook/pushing/

10. Manage your cluster
  ```
  minikube pause
  minikube unpause
  minikube stop
  minikube delete --all
  minikube profile list
  minikube profile <new-profile>
  minikube ssh
  ```


