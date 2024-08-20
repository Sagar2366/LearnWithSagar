# Before getting started:
1. Follow the instructions from the previous video to create a cluster with v1.30.3: https://github.com/Sagar2366/LearnWithSagar/blob/main/CKA/6_kubeadm_k8s_cluster_setup.md
2. Make sure to change in the <b>Install kubelet, kubeadm and kubectl</b>
```
# Update the apt package index and install packages needed to use the Kubernetes apt repository:
  sudo apt-get update
# apt-transport-https may be a dummy package; if so, you can skip that package
  sudo apt-get install -y apt-transport-https ca-certificates curl gpg

# Download the public signing key for the Kubernetes package repositories. The same signing key is used for all repositories so you can disregard the version in the URL:
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# Add the appropriate Kubernetes apt repository.
# Please note that this repository have packages only for Kubernetes 1.30; for other Kubernetes minor versions, you need to change the Kubernetes minor version in the URL to match your desired minor version
# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Update the apt package index, install kubelet, kubeadm and kubectl, and pin their version:
sudo apt-get update
sudo apt-get install -y kubelet=1.30.3-1.1 kubeadm=1.30.3-1.1 kubectl=1.30.3-1.1
sudo apt-mark hold kubelet kubeadm kubectl

# Enable the kubelet service before running kubeadm:
  sudo systemctl enable --now kubelet
```
3. Use the kubeadm init with version to to be installed
   ```
   kubeadm init --kubernetes-version=1.30.3
   ```

# Upgarde Kubeadm Clusters

1. [Version Skew policy](https://kubernetes.io/releases/version-skew-policy/#supported-version-skew)
```
- Kubernetes versions are expressed as x.y.z, where x is the major version, y is the minor version, and z is the patch version.
- The Kubernetes project maintains release branches for the most recent three minor releases (1.31, 1.30, 1.29).

Example:
- kube-apiserver is at 1.31
- kubelet is supported at 1.31, 1.30, 1.29, and 1.28
- kube-proxy is supported at 1.31, 1.30, 1.29, and 1.28
- kube-controller-manager, kube-scheduler, and cloud-controller-manager are supported at 1.31 and 1.30
- kubectl is supported at 1.32, 1.31, and 1.30
```

# Before you begin 
```
- Make sure you read the release notes carefully.
- The cluster should use a static control plane and etcd pods or external etcd.
- Make sure to back up any important components, such as app-level state stored in a database.
  kubeadm upgrade does not touch your workloads, only components internal to Kubernetes, but backups are always a best practice.
- Swap must be disabled.
```

## [Changing the package repository](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/change-package-repository/)
1. Open the file that defines the Kubernetes apt repository using a text editor of your choice:
```
vi /etc/apt/sources.list.d/kubernetes.list
```
2. Change the version in the URL to the next available minor release, for example:
```
deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /
```
3. Save the file and exit your text editor. Continue following the relevant upgrade instructions.


# Determine which version to upgrade to
```
# Find the latest 1.31 version in the list.
# It should look like 1.31.x-*, where x is the latest patch.
sudo apt update
sudo apt-cache madison kubeadm
```


# Upgrdaing control plane nodes
The upgrade procedure on control plane nodes should be executed one node at a time. Pick a control plane node that you wish to upgrade first. It must have the /etc/kubernetes/admin.conf file.
1. Upgrade kubeadm
```
# replace x in 1.31.x-* with the latest patch version
sudo apt-mark unhold kubeadm && \
sudo apt-get update && sudo apt-get install -y kubeadm='1.31.x-*' && \
sudo apt-mark hold kubeadm
```
2. Verify that the download works and has the expected version:
```
kubeadm version
```
3. Verify the upgrade plan:
```
sudo kubeadm upgrade plan
```
4. Choose a version to upgrade to, and run the appropriate command. For example:
```
# replace x with the patch version you picked for this upgrade
kubeadm config images pull
sudo kubeadm upgrade apply v1.31.x
```
5. Manually upgrade your CNI provider plugin.

6. For the other control plane nodes execute ``` sudo kubeadm upgrade node ``` instead of ``` sudo kubeadm upgrade apply ```

7. Drain the node
Prepare the node for maintenance by marking it unschedulable and evicting the workloads:
```
# replace <node-to-drain> with the name of your node you are draining
kubectl drain <node-to-drain> --ignore-daemonsets
```

8. Upgrade kubelet and kubectl
```
# replace x in 1.31.x-* with the latest patch version
sudo apt-mark unhold kubelet kubectl && \
sudo apt-get update && sudo apt-get install -y kubelet='1.31.x-*' kubectl='1.31.x-*' && \
sudo apt-mark hold kubelet kubectl
```

9. Restart the kubelet
```
sudo systemctl daemon-reload
sudo systemctl restart kubelet
sudo status kubelet
journalctl -xeu kubelet
```

10. Uncordon the node
Bring the node back online by marking it schedulable:
```
# replace <node-to-uncordon> with the name of your node
kubectl uncordon <node-to-uncordon>
```


# Upgrade worker nodes
[Changing the package repository](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/change-package-repository/)
1. Open the file that defines the Kubernetes apt repository using a text editor of your choice:
```
vi /etc/apt/sources.list.d/kubernetes.list
```
2. Change the version in the URL to the next available minor release, for example:
```
deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /
```
3. Save the file and exit your text editor. Continue following the relevant upgrade instructions.

4. Determine which version to upgrade to
```
# Find the latest 1.31 version in the list.
# It should look like 1.31.x-*, where x is the latest patch.
sudo apt update
sudo apt-cache madison kubeadm
```

5. Upgrade kubeadm
```
# replace x in 1.31.x-* with the latest patch version
sudo apt-mark unhold kubeadm && \
sudo apt-get update && sudo apt-get install -y kubeadm='1.31.x-*' && \
sudo apt-mark hold kubeadm
```

6. Upgrade local kubelet configuration
```
sudo kubeadm upgrade node
```

7. Prepare the node for maintenance by marking it unschedulable and evicting the workloads:
   <b>Note: Execute this command from terminal where you have kubectl access.</b>
```
# execute this command on a control plane node
# replace <node-to-drain> with the name of your node you are draining
kubectl drain <node-to-drain> --ignore-daemonsets
```

8. Upgrade kubelet and kubectl
```
# replace x in 1.31.x-* with the latest patch version
sudo apt-mark unhold kubelet kubectl && \
sudo apt-get update && sudo apt-get install -y kubelet='1.31.x-*' kubectl='1.31.x-*' && \
sudo apt-mark hold kubelet kubectl
```

9. Restart the kubelet
```
sudo systemctl daemon-reload
sudo systemctl restart kubelet
sudo status kubelet
journalctl -xeu kubelet
```

10. Uncordon the node
Bring the node back online by marking it schedulable:
<b>Note: Execute this command from terminal where you have kubectl access.</b>
```
# execute this command on a control plane node
# replace <node-to-uncordon> with the name of your node
kubectl uncordon <node-to-uncordon>
```

# Verify the cluster upgrade
1. kubectl get nodes
2. kubectl get pods -A


# Drain: pods gracefully terminated and rescheduled on other nodes, cordon the node

# Cordon: Unschedulable, new pods will not be scheduled, doesn't terminate existing running pods

# Uncordon: New pod will schedule, previously terminated/moved pods will not be scheduled automatically here


# K8S Software Versions
v1.31.1 - api server, controller-manager, scheduler, kubelet, kube-proxy, kubectl
etcd and coredns are separate projects

1 - Major
31 - Minor, features: every few months
1 - Bug fixes: releases more often

api server: x
kubectl x, x+1, x-1
controller-manager, kube-scheduler: x,x-1
kubelet, kubeproxy: x, x-1, x-2

support latest 3 releases
Upgrade one minor release at a time

# Exam tip: May ask you to only upgrade controlplane, read question carefully

