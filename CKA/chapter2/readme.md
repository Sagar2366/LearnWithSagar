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

# Kubernetes API workflow

# How to access the remote Kubernetes cluster with Kubeconfig file

# Command Line tool to access Kubernetes Cluster

# Kubernetes Dashboard

# YAML basics




