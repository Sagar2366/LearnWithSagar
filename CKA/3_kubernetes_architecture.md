
# What is Kubernetes
- Portable, extensible and Open Source platform for managing containerised workload and services
- Originally developed by Google and opensourced in 2014
- Helps managing containerised applications in different environments (Physical machines, Cloud, virtual machines, hybrid)

# What problems Kubernetes Solves
- Containers are efficient for running applications, but managing them in production to prevent downtime can be challenging.
- Kubernetes addresses this by providing a resilient framework for running distributed systems resiliently.
- It handles tasks like <b>scaling</b>, failover, <b>load balancing</b>, storage orchestration, automated rollouts/rollbacks, <b>resource optimization</b>, <b>self-healing</b>, secret management, batch execution, horizontal scaling, and <b>extensibility</b>.
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
![kubernetes-cluster-architecture](https://github.com/user-attachments/assets/d151bb01-febe-4289-93e1-25d3dca250ae)



- In its simplest form, Kubernetes is made of control plane nodes (aka cp nodes) and worker nodes to run containerized applications, once called minions.
- The control plane manages these nodes and Pods, typically running across multiple machines in production for fault tolerance and high availability.
- The cp runs an API server, a scheduler, various controllers and a storage system to keep the state of the cluster, container settings, and the networking configuration.
- As a concept, the various pods responsible for ensuring the current state of the cluster matches the desired state are called the control plane.
- When building a cluster using kubeadm, the kubelet process is managed by systemd. Once running, it will start every pod found in <b>/etc/kubernetes/manifests/</b>.

## Control plane components:
1. <b>Kube-api server</b> :
- The kube-apiserver is the central component of the Kubernetes control plane, acting as the front end for the entire cluster.
- It <b>handles all internal and external traffic, validating and processing API requests</b>, and is the sole connection to the etcd database.
- When developers issue commands via kubectl, the API server receives these commands, authenticates, validates them, and coordinates the necessary actions to implement them.
- It exposes the Kubernetes API, facilitating communication between all components of the cluster and ensuring that the cluster's state is accurately maintained.
- Port: 6443
- Check kube-api-server pod
  ```
  kubectl get pods -n kube-system | grep -i kube-api-server
  kubectl exec -it <kube-api-server-pod-id> -- cat /etc/kubernetes/manifests/kube-apiserver.yaml
  ```

2. <b>kube-controller-manager</b> :
- The kube-controller-manager is a core component of the Kubernetes control plane that runs various controller processes to <b>ensure the cluster's desired state matches its actual state</b>.
- It interacts with the kube-apiserver to monitor the cluster, and if discrepancies are found, it instructs the appropriate controller to take action.
- Controllers like the Node controller, Job controller, and ServiceAccount controller handle specific tasks, such as managing node availability, running jobs, and creating service accounts.
- Although each controller operates logically as a separate process, they are combined into a single binary to reduce complexity.
- Port: 10257
- Check kube-controller-manager server pod
  ```
  kubectl get pods -n kube-system | grep -i kube-controller-manager
  kubectl exec -it <kube-controller-manager-pod-id> -- cat /etc/kubernetes/manifests/kube-controller-manager.yaml
  ```

3. <b>kube-scheduler</b> :
- The kube-scheduler is a control plane component <b>responsible for determining which node will host a newly created Pod</b>.
- It uses an algorithm that considers factors like resource availability, hardware/software constraints, affinity/anti-affinity rules, and data locality.
- The scheduler attempts to deploy the Pod, retrying if necessary.
- It can be customized or replaced with a custom scheduler.
- Once the API Server gathers information from the Controller Manager, it notifies the scheduler to assign the Pod to a suitable node.
- Port: 10259
- Check kube-scheduler pod
  ```
  kubectl get pods -n kube-system | grep -i etcd
  kubectl exec -it <etcd-pod-id> -- cat /etc/kubernetes/manifests/etcd.yaml
  ```

4. <b>etcd</b> :
- Etcd is a <b>consistent and highly-available key-value store</b> used as the backing database for all Kubernetes cluster data, including information about Pods, nodes, and networking configurations.
- It operates as a B+ tree, appending new values rather than modifying existing entries, with old data marked for removal through a compaction process.
- All updates to etcd are routed through the kube-apiserver, which handles simultaneous requests sequentially, ensuring consistency.
- It's crucial to have a backup plan for the data stored in etcd, given its importance in maintaining the cluster's state.
- Port: 2379-2380
- Check etcd pod
  ```
  kubectl get pods -n kube-system | grep -i kube-scheduler
  kubectl exec -it <kube-scheduler-pod-id> -- cat /etc/kubernetes/manifests/kube-scheduler.yaml
  ```

5. <b>cloud-controller-manager</b> :
- The cloud-controller-manager is a Kubernetes control plane component that integrates cloud-specific control logic with your cluster.
- It allows the cluster to interact with a cloud provider's API while separating cloud-dependent components from those that only interact with the cluster.
- The cloud-controller-manager runs only cloud-specific controllers, such as the Node, Route, and Service controllers, which handle tasks like checking node status, setting up routes, and managing cloud load balancers.

## Worker node components:
1. <b>kubelet</b> :
- The kubelet is a crucial component of the Kubernetes worker node that manages Pods based on their specifications (PodSpecs).
- It <b>registers worker node as well as configures the local node to meet the Pod's requirements, including mounting volumes and accessing Secrets or ConfigMaps</b>.
- The kubelet communicates with the local container engine, reports the Pod and node status to the kube-apiserver, and ensures that Pods are running correctly.
- If a Pod fails, the kubelet will create a new one to replace it, since failed Pods cannot be restarted.
- Port: 10250
- Check kubelet configuration file and process
  ```
  cat /var/lib/kubelet/config.yaml
  ps -aux | grep kubelet
  ```
  
2. <b>kube-proxy</b> :
- kube-proxy is a network proxy that runs on each node in your cluster, implementing part of the Kubernetes Service concept.
- kube-proxy maintains network rules on nodes. These network rules allow network communication to your Pods from network sessions inside or outside your cluster.
- Port: 10256
- Check kube-scheduler pod
  ```
  kubectl get daemonset kube-proxy -n kube-system
  kubectl get pods -n kube-system | grep -i kube-proxy
  kubectl exec -it <kube-proxy-pod-id> -- cat /etc/kubernetes/manifests/kube-proxy.yaml
  ```

3. <b>container engine</b> :
- The Container Engine in Kubernetes interacts with the container runtime to provide the environment needed for containers.
- It manages the creation and lifecycle of containers within the Kubernetes environment. Common container engines include CRI-O and containerd.
- Kubernetes supports container runtimes that adhere to the Kubernetes Container Runtime Interface (CRI), enabling effective container management.
- To manage containers running in your Kubernetes cluster
  ```
  crictl ps
  critctl images
  ```


## What Was Dockershim? Why Kubernetes Dropped the Docker Support?
![kubelet_1_diagram-2](https://github.com/user-attachments/assets/5d6b89d7-1710-424a-88ce-2b535e6269f2)

When Kubernetes used Docker as a container runtime, the process involves multiple steps and intermediaries:
1. kubelet Instruction: Kubernetes' kubelet receives an instruction to start a container.
2. Dockershim Translation: kubelet sends this instruction to dockershim, which translates it into a language that Docker can understand.
3. Docker Processing: Docker receives the translated message but does not directly handle the container image. Instead, Docker passes the task to containerd, a lower-level container runtime.
4. containerd Execution: containerd downloads the container image, prepares it, and instructs runc to starts the container.

This multi-step process involves several layers of communication: kubelet to dockershim, dockershim to Docker, and Docker to containerd, and containerd to runc. <br>
Kubernetes developers decided to remove Docker as a runtime because these intermediaries create unnecessary complexity and inefficiency.  <br>
By eliminating Docker, Kubernetes can simplify the container startup process, reducing the number of steps and improving performance. <br>
Kubernetes moved away from Docker because Docker's unnecessary plugins, like volume and network management, add overhead. 
Kubernetes has its own systems for these tasks, making Docker's plugins redundant.

## Kubernetes Docker Deprecation Makes Everything Simpler

![kubeletet_2_diagram-2](https://github.com/user-attachments/assets/deb1fca2-fd6c-4ca2-b925-dd56f09769d7)

After Kubernetes removed dockershim and Docker, the process of starting containers became much simpler and more efficient:

1. Previous Complexity:
   - Originally, kubelet sent instructions to dockershim, which translated them for Docker.
   - Docker then passed the task to containerd, the actual component responsible for downloading images and starting containers.
   - This multi-step process involved several intermediaries, creating unnecessary complexity.

2. Streamlined Process:
   - Kubernetes developers recognized that containerd was doing the actual work, so they decided to bypass Docker and dockershim altogether.
   - Now, kubelet communicates directly with containerd.
   - Although kubelet and containerd don’t naturally "speak the same language," containerd includes a CRI plugin that handles the necessary translations internally.

3. Performance Improvement:
   - With fewer components and translation steps, the process of starting containers is faster.
   - Even small improvements, like reducing container start times by 0.1 seconds, can significantly enhance performance when scaling to hundreds of containers.
   - This change makes Kubernetes more efficient and responsive.
   - 

## [Performance Improvement](https://kubernetes.io/blog/2018/05/24/kubernetes-containerd-integration-goes-ga/#performance)
Improving performance was one of the major focus items for the containerd 1.1 release. Performance was optimized in terms of pod startup latency and daemon resource usage.

The following results are a comparison between containerd 1.1 and Docker 18.03 CE on 105 pods. The containerd 1.1 integration uses the CRI plugin built into containerd; and the Docker 18.03 CE integration uses the dockershim.

The results were generated using the Kubernetes node performance benchmark
![memory](https://github.com/user-attachments/assets/c59fedcc-5d4e-4a73-9048-35b619c50e4f)
![cpu](https://github.com/user-attachments/assets/7ed89560-9f3a-4d87-a289-d797c97fbdd0)
![latency](https://github.com/user-attachments/assets/ab6d74f2-95c7-4f40-9ffb-534e83cd2791)

