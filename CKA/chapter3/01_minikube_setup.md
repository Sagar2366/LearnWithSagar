<h1> Minikube: Local Kubernetes Cluster</h1>

minikube is a tool that lets you run Kubernetes locally. <br>
minikube runs an all-in-one or a multi-node local Kubernetes cluster on your personal computer (including Windows, macOS and Linux PCs) so that you can try out Kubernetes, or for daily development work.

## What you’ll need
```
2 CPUs or more
2GB of free memory
20GB of free disk space
Internet connection
Container or virtual machine manager, such as: Docker, QEMU, Hyperkit, Hyper-V, KVM, Parallels, Podman, VirtualBox, or VMware Fusion/Workstation
 ```


To install the latest minikube stable release on x86-64 Linux using binary download:
```
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64
```

Note: Follow the installation steps for other OS releases from [here](https://minikube.sigs.k8s.io/docs/start/?arch=%2Fmacos%2Fx86-64%2Fstable%2Fbinary+download).


Start minikube cluster:
```
minikube start --nodes 2 -p multinode-demo
```

Read more:
1. Basics controls: https://minikube.sigs.k8s.io/docs/handbook/controls/
2. Pushing Docker images to minikube cluster: https://minikube.sigs.k8s.io/docs/handbook/pushing/
3. Accessing Services:
4. Minikube dashboard: https://minikube.sigs.k8s.io/docs/handbook/dashboard/
5. Configurations: https://minikube.sigs.k8s.io/docs/handbook/config/
6. Deploying apps: https://minikube.sigs.k8s.io/docs/handbook/deploying/
7. 
