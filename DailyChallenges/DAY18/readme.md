# Day18 Challenge: Build Your Kubernetes Playground with Minikube and Kubeadm

Hello Learners,


Welcome back to the DevOps SRE Daily Challenge! 🎉
Today, we’ll explore two essential methods for setting up Kubernetes clusters: Minikube for local, single-node setups and Kubeadm for multi-node, production-like environments.



### What You'll Learn:
- How to install and configure Minikube for a single-node Kubernetes cluster.
- How to set up a Kubernetes cluster using Kubeadm.
- Core differences between Minikube and Kubeadm setups.

## Challenge Tasks
1. Minikube Setup
- Install Minikube on your system (Windows/Linux/Mac).
    Reference: [Minikube Installation Guide](https://github.com/Sagar2366/LearnWithSagar/blob/main/CKA/5_minikube_installation.md)
- Start a Minikube cluster and verify its status:
```
minikube start
minikube status
```

- List all available nodes in the cluster:
``` kubectl get nodes```
- Share the output of kubectl get nodes in your submission.

2. Kubeadm Cluster Setup
- Use Kubeadm to set up a 3-node Kubernetes cluster (1 control plane, 2 nodes).
    Reference: [Kubeadm Kubernetes Cluster Setup](https://github.com/Sagar2366/LearnWithSagar/blob/main/CKA/6_kubeadm_k8s_cluster_setup.md)
- Key steps include:
  - Setting up prerequisites (e.g., container runtime, kubelet, kubeadm, kubectl).
  - Initializing the control plane using kubeadm init.
  - Joining a node to the cluster using the kubeadm join command.
- Verify the cluster setup with: ```kubectl get nodes```
- Share screenshots of the control-plane and node status.

3. Theory Comparison
- Write a brief explanation comparing Minikube and Kubeadm setups. Address the following:
- Use cases for Minikube vs. Kubeadm.
- How they differ in cluster complexity and purpose.

## Bonus Task
- Install and enable the Kubernetes dashboard on your Kubernetes cluster.
- Access the dashboard and share a screenshot.

## Submission Guidelines
- Outputs of kubectl get nodes for both Minikube and Kubeadm setups.
- Screenshots showing the successful cluster setup.
- Minikube vs. Kubeadm
- Post your experience on social media with the hashtags: #getfitwithsagar, #SRELife, #DevOpsForAll #ckawithsagar

## Resources to Help You:
- [Minikube and Kubeadm Setup](https://www.youtube.com/watch?v=WUAwpzoQsuU)
- [Kubeadm Kubernetes Cluster Guide](https://www.youtube.com/watch?v=KzSw23tgHDQ)
- Kubernetes Official Docs: https://kubernetes.io/docs

If you missed any previous challenges, you can catch up by reviewing the problem statements on GitHub.


Best regards,</br>
Sagar Utekar
