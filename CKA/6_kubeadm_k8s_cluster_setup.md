# Setup Multinode Kubernetes cluster using kubeadm on AWS EC2 

## Before getting started
```
1. Create AWS VPC for Kubernetes cluster
   - CIDR Range (172.31.0.0/16)
   - Public Subnet for Bastion
   - Private Subnet for cluster nodes
2. Create Bastion node
   - instance size: t2.micro
   - Use bastion security group
   - Use Public Subnet
3. Create Controlplane node
   - instance size: t2.medium
   - Use controlplane-sg security group. Add ssh connection from bastion, 6783/tcp,6783/udp,6784/udp for Weavenet CNI
   - Use private subnet
4. Create worker nodes
   - Number of instances: 2
   - Instance type: t2.micro
   - Use workernode-sg security group. Add ssh connection from bastion, 6783/tcp,6783/udp,6784/udp for Weavenet CNI
   - Use private subnet
```

## Pre-requisites
```
- A compatible Linux host.
- 2 GB or more of RAM per machine (any less will leave little room for your apps).
- 2 CPUs or more.
- Full network connectivity between all machines in the cluster (public or private network is fine).
- Unique hostname, MAC address, and product_uuid for every node.
- Certain ports are open on your machines:
  ```
<img width="718" alt="Screenshot 2024-08-18 at 10 30 09 AM" src="https://github.com/user-attachments/assets/618df8a7-b70f-49d1-9130-508644321b4b">

```
- Swap configuration. The default behavior of a kubelet was to fail to start if swap memory was detected on a node.
  You MUST disable swap if the kubelet is not properly configured to use swap.
  For example, sudo swapoff -a will disable swapping temporarily.
  To make this change persistent across reboots, make sure swap is disabled in config files like /etc/fstab, systemd.swap, depending how it was configured on your system.
- Supported CRI complaint container runtime: containerd, CRI-O
```

# Update hostnames on all nodes:
```
Update /etc/hostname file with node name and restart the nodes
```

# Exceute on all cluster nodes as root user
1. Disable swap space
   ```
   swapoff -a
   sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
   ```
2. Installing container runtime : [containerd](https://github.com/containerd/containerd/blob/main/docs/getting-started.md) and runc
```   
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install containerd.io
```

3. Configure containerd to use [systemd group](https://kubernetes.io/docs/setup/production-environment/container-runtimes/#containerd-systemd): 

```
containerd config default > /etc/containerd/config.toml
#To use the systemd cgroup driver in /etc/containerd/config.toml with runc, set

[plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]
  ...
  [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]
    SystemdCgroup = true

# Restrat containerd service
  sudo systemctl restart containerd
```

4. Install [CNI Plugin](https://github.com/containerd/containerd/blob/main/docs/getting-started.md#step-3-installing-cni-plugins)
   ```
   wget https://github.com/containernetworking/plugins/releases/download/v1.5.0/cni-plugins-linux-amd64-v1.5.0.tgz
   mkdir -p /opt/cni/bin
   tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.5.0.tgz
   ```
5. Install [crictl](https://github.com/kubernetes-sigs/cri-tools/blob/master/docs/crictl.md)
   ```
   VERSION="v1.30.0" # check latest version in /releases page
   wget https://github.com/kubernetes-sigs/cri-tools/releases/download/$VERSION/crictl-$VERSION-linux-amd64.tar.gz
   sudo tar zxvf crictl-$VERSION-linux-amd64.tar.gz -C /usr/local/bin
   rm -f crictl-$VERSION-linux-amd64.tar.gz

   cat <<EOF | sudo tee /etc/crictl.yaml
   runtime-endpoint: unix:///run/containerd/containerd.sock
   image-endpoint: unix:///run/containerd/containerd.sock
   timeout: 2
   debug: false
   pull-image-on-create: false
   EOF
   ```
   

6. [Enable IPV4 Packet forwarding](https://kubernetes.io/docs/setup/production-environment/container-runtimes/#prerequisite-ipv4-forwarding-optional)
```
   # sysctl params required by setup, params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.ipv4.ip_forward = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system

#Verify that net.ipv4.ip_forward is set to 1 with:
sysctl net.ipv4.ip_forward
```
7. [Install kubelet, kubeadm and kubectl](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#installing-kubeadm-kubelet-and-kubectl)
   ```
   # Update the apt package index and install packages needed to use the Kubernetes apt repository:
     sudo apt-get update
   # apt-transport-https may be a dummy package; if so, you can skip that package
     sudo apt-get install -y apt-transport-https ca-certificates curl gpg

   # Download the public signing key for the Kubernetes package repositories. The same signing key is used for all repositories so you can disregard the version in the URL:
   curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

   # Add the appropriate Kubernetes apt repository.
   # Please note that this repository have packages only for Kubernetes 1.31; for other Kubernetes minor versions, you need to change the Kubernetes minor version in the URL to match your desired minor version
   # This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
   echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

   # Update the apt package index, install kubelet, kubeadm and kubectl, and pin their version:
   sudo apt-get update
   sudo apt-get install -y kubelet kubeadm kubectl
   sudo apt-mark hold kubelet kubeadm kubectl

   # Enable the kubelet service before running kubeadm:
     sudo systemctl enable --now kubelet
   ```

# Execute only on controlplane node
1. Initalise kubernetes cluster
```
  kubeadm config images pull
  kubeadm init
```
2. Install Network addon [CNI complaint CNI Plugin](https://kubernetes.io/docs/concepts/cluster-administration/addons/#networking-and-network-policy)- [weavenet](https://github.com/weaveworks/weave/blob/master/site/kubernetes/kube-addon.md):
   ```
   kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
   ``` 



# Execute only on worker nodes
Run the join command obtained from kubeadm init output on all Workers nodes. Example
```
kubeadm join <controlplane>:6443 --token <<token>>         --discovery-token-ca-cert-hash sha256:<<token>>
```



# Recreate a token
By default, tokens expire after 24 hours. 
If you are joining a node to the cluster after the current token has expired, you can create a new token by running the following command on the control-plane node:
```
kubeadm token create --print-join-command
```

# Reset kubeadm setup: 
Execute ```kubeadm reset``` on all nodes to reset all kubeadm init configurations
## Verify the setup
```
kubectl get nodes
kubectl get pods -A
```

## Deploy sample pod
```
kubectl run nginx --image=nginx --port=80 
kubectl expose pod nginx --port=80 --type=NodePort
```
