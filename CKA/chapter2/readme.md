# What is Kubernetes
- Portable, extensible and Open Source platform for managing containerised workload and services
- Originally developed by Google and opensourced in 2014
- Helps managing containerised applications in different environments (Physical machines, Cloud, virtual machines, hybrid)


  
# Going back in time
![Container_Evolution](https://github.com/user-attachments/assets/0eb4d838-5647-4af3-8013-217efd023a4b)

- In the Traditional deployment era, applications ran on physical servers without resource boundaries, leading to inefficiencies and high costs. 
- The Virtualized deployment era introduced virtualization, allowing multiple Virtual Machines (VMs) on a single server, improving resource utilization, scalability, and security. 
- The Container deployment era further optimized resource use by sharing the OS among applications in lightweight containers.
  Containers are portable across different clouds and OS distributions, enabling agile application development, continuous integration, and easy rollbacks.
  Containers offer consistency across development, testing, and production environments, and support application-centric management.
  They enhance resource efficiency, performance predictability, and are ideal for managing distributed, elastic microservices.

# What problems Kubernetes Solves
- Containers are efficient for running applications, but managing them in production to prevent downtime can be challenging.
- Kubernetes addresses this by providing a resilient framework for running distributed systems resiliently.
- It handles tasks like scaling, failover, load balancing, storage orchestration, automated rollouts/rollbacks, resource optimization, self-healing, secret management, batch execution, 
  horizontal scaling, and extensibility.
- Kubernetes ensures applications run smoothly, automatically adapting to changes and failures without manual intervention.

# Features of Kubernetes
- <b>Service discovery and load balancing: </b> Kubernetes can expose a container using the DNS name or using their own IP address. If traffic to a container is high, Kubernetes is able to load balance and distribute the network traffic so that the deployment is stable.
- <b>Storage orchestration: </b> Kubernetes allows you to automatically mount a storage system of your choice, such as local storages, public cloud providers, and more.
- <b>Automated rollouts and rollbacks: </b> You can describe the desired state for your deployed containers using Kubernetes, and it can change the actual state to the desired state at a controlled rate. For example, you can automate Kubernetes to create new containers for your deployment, remove existing containers and adopt all their resources to the new container.
- <b>Automatic bin packing: </b> You provide Kubernetes with a cluster of nodes that it can use to run containerized tasks. You tell Kubernetes how much CPU and memory (RAM) each container needs. Kubernetes can fit containers onto your nodes to make the best use of your resources.
- <b>Self-healing: </b> Kubernetes restarts containers that fail, replaces containers, kills containers that don't respond to your user-defined health check, and doesn't advertise them to clients until they are ready to serve.
- <b>Secret and configuration management: </b> Kubernetes lets you store and manage sensitive information, such as passwords, OAuth tokens, and SSH keys. You can deploy and update secrets and application configuration without rebuilding your container images, and without exposing secrets in your stack configuration.
- <b>Batch execution: </b> In addition to services, Kubernetes can manage your batch and CI workloads, replacing containers that fail, if desired.
- <b>Horizontal scaling: </b> Scale your application up and down with a simple command, with a UI, or automatically based on CPU usage.
- <b>IPv4/IPv6 dual-stack: </b> Allocation of IPv4 and IPv6 addresses to Pods and Services
- <b>Designed for extensibility: </b> Add features to your Kubernetes cluster without changing upstream source code.


# Kubernetes Architecture
![k8s_arch](https://github.com/user-attachments/assets/7416fb41-edcb-4db5-89a9-403b7611b23e)


- In its simplest form, Kubernetes is made of control plane nodes (aka cp nodes) and worker nodes to run containerized applications, once called minions.
- The control plane manages these nodes and Pods, typically running across multiple machines in production for fault tolerance and high availability.
- The cp runs an API server, a scheduler, various controllers and a storage system to keep the state of the cluster, container settings, and the networking configuration.
- As a concept, the various pods responsible for ensuring the current state of the cluster matches the desired state are called the control plane.
- When building a cluster using kubeadm, the kubelet process is managed by systemd. Once running, it will start every pod found in <b>/etc/kubernetes/manifests/</b>.

## Control plane components:
1. <b>Kube-api server</b> :
- The kube-apiserver is the central component of the Kubernetes control plane, acting as the front end for the entire cluster.
- It handles all internal and external traffic, validating and processing API requests, and is the sole connection to the etcd database.
- When developers issue commands via kubectl, the API server receives these commands, validates them, and coordinates the necessary actions to implement them.
- It exposes the Kubernetes API, facilitating communication between all components of the cluster and ensuring that the cluster's state is accurately maintained.

2. <b>kube-controller-manager</b> :
- The kube-controller-manager is a core component of the Kubernetes control plane that runs various controller processes to ensure the cluster's desired state matches its actual state.
- It interacts with the kube-apiserver to monitor the cluster, and if discrepancies are found, it instructs the appropriate controller to take action.
- Controllers like the Node controller, Job controller, and ServiceAccount controller handle specific tasks, such as managing node availability, running jobs, and creating service accounts.
- Although each controller operates logically as a separate process, they are combined into a single binary to reduce complexity.

3. <b>kube-scheduler</b> :
- The kube-scheduler is a control plane component responsible for determining which node will host a newly created Pod.
- It uses an algorithm that considers factors like resource availability, hardware/software constraints, affinity/anti-affinity rules, and data locality.
- The scheduler attempts to deploy the Pod, retrying if necessary.
- It can be customized or replaced with a custom scheduler.
- Once the API Server gathers information from the Controller Manager, it notifies the scheduler to assign the Pod to a suitable node.

4. <b>etcd</b> :
- Etcd is a consistent and highly-available key-value store used as the backing database for all Kubernetes cluster data, including information about Pods, nodes, and networking configurations.
- It operates as a B+ tree, appending new values rather than modifying existing entries, with old data marked for removal through a compaction process.
- All updates to etcd are routed through the kube-apiserver, which handles simultaneous requests sequentially, ensuring consistency.
- It's crucial to have a backup plan for the data stored in etcd, given its importance in maintaining the cluster's state.

5. <b>cloud-controller-manager</b> :
- The cloud-controller-manager is a Kubernetes control plane component that integrates cloud-specific control logic with your cluster.
- It allows the cluster to interact with a cloud provider's API while separating cloud-dependent components from those that only interact with the cluster.
- The cloud-controller-manager runs only cloud-specific controllers, such as the Node, Route, and Service controllers, which handle tasks like checking node status, setting up routes, and managing cloud load balancers.

## Worker node components:
1. <b>kubelet</b> :
- The kubelet is a crucial component of the Kubernetes worker node that manages Pods based on their specifications (PodSpecs).
- It configures the local node to meet the Pod's requirements, including mounting volumes and accessing Secrets or ConfigMaps.
- The kubelet communicates with the local container engine, reports the Pod and node status to the kube-apiserver, and ensures that Pods are running correctly.
- If a Pod fails, the kubelet will create a new one to replace it, since failed Pods cannot be restarted.
  
2. <b>kube-proxy</b> :
- kube-proxy is a network proxy that runs on each node in your cluster, implementing part of the Kubernetes Service concept.
- kube-proxy maintains network rules on nodes. These network rules allow network communication to your Pods from network sessions inside or outside of your cluster.

3. <b>container engine</b> :
- The Container Engine in Kubernetes interacts with the container runtime to provide the environment needed for containers.
- It manages the creation and lifecycle of containers within the Kubernetes environment. Common container engines include CRI-O and containerd.
- Kubernetes supports container runtimes that adhere to the Kubernetes Container Runtime Interface (CRI), enabling effective container management.

  
# Discussion: Kubernetes API workflow

# TODO

# How to access the remote Kubernetes cluster with Kubeconfig file

# Command Line tool to access Kubernetes Cluster

# Kubernetes Dashboard

# YAML basics

# Minikube setup

# Kubeadm setup

# Kubectl guide

# 




