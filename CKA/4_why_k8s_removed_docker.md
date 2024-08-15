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

