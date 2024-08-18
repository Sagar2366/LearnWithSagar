# Setup Multinode Kubernetes cluster using kubeadm on AWS EC2 

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


# Installing container runtime


# Create ec2 instances: 
- Controlplane Node: 
    Instance Type: t2.medium
    Number of Instances: 1
- Worker Nodes:
    Instance Type: t2.micro
    Number of Instances: 2


# Update hostnames:
```
Update /etc/hostname file with node name and restart the nodes
```

# Update security groups to enable ports

# Enable IPV4 Packet forwarding

# Disable swap

# Install container runtime: containerd

# Load default containerd config 

# Configure containerd to use cgroup systemd driver

# restart containerd and verify the status

# install kubeadm, lubelet and kubectl on control plane and worker nodes

# initialise control plane node

# Join worker nodes

# Recreate a token

# Install network addon


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
