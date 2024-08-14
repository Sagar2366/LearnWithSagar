<h1>Container Fundamentals</h1>

## Going back in time
![Container_Evolution](https://github.com/user-attachments/assets/0eb4d838-5647-4af3-8013-217efd023a4b)

- In the Traditional deployment era, applications ran on physical servers without resource boundaries, leading to inefficiencies and high costs. 
- The Virtualized deployment era introduced virtualization, allowing multiple Virtual Machines (VMs) on a single server, improving resource utilization, scalability, and security. 
- The Container deployment era further optimized resource use by sharing the OS among applications in lightweight containers.
  Containers are portable across different clouds and OS distributions, enabling agile application development, continuous integration, and easy rollbacks.
  Containers offer consistency across development, testing, and production environments, and support application-centric management.
  They enhance resource efficiency, performance predictability, and are ideal for managing distributed, elastic microservices.
  
## What is Docker?
- Docker is a platform that enables you to package and run applications in isolated environments called containers.
- These containers are lightweight, secure, and contain everything needed to run the application, which means they don't depend on the host system's configuration.
- Docker allows multiple containers to run simultaneously on a single host, making it efficient for resource usage.

### Key features of Docker include:
1. <b>Development</b>: Create your application and its dependencies within containers.
2. <b>Distribution and Testing</b>: Containers serve as the unit of distribution and testing for your application, ensuring consistency across different environments.
3. <b>Deployment</b>: Deploy your application in production as a container or an orchestrated service, whether in a local data center, the cloud, or a hybrid environment.
This ensures that the application behaves the same way in different environments, facilitating collaboration and reducing potential issues caused by environmental differences.


## Docker Architecture:
![docker-architecture (1)](https://github.com/user-attachments/assets/cd74eb73-d084-438f-8a1b-2b5d7e997c89)


- Docker uses a client-server architecture.
- The Docker client talks to the Docker daemon, which does the heavy lifting of building, running, and distributing your Docker containers.

1. <b>Docker Daemon (dockerd)</b>:
- The Docker daemon listens for Docker API requests and manages Docker objects like images, containers, networks, and volumes.

2. <b>Docker Client (docker)</b>:
- The Docker client is the primary interface for most Docker users. It sends commands, like docker run, to the Docker daemon using the Docker API, enabling the daemon to execute them.

3. <b>Docker Desktop</b>:
- Docker Desktop is an easy-to-install application for Mac, Windows, or Linux that allows users to build and share containerized applications and microservices.
- It includes the Docker daemon, Docker client, Docker Compose, Docker Content Trust, Kubernetes, and Credential Helper.

4. <b>Docker Registries</b>:
- A Docker registry stores Docker images.
- Docker Hub is the default public registry, but users can also run private registries.
- Commands like docker pull and docker run fetch images from a registry, while docker push uploads images to a registry.

5. <b>Docker Objects</b>:
Docker manages various objects such as images, containers, networks, volumes, and plugins.
```
Images:
- An image is a read-only template that contains instructions for creating a Docker container.
- Images can be customized and are built using a Dockerfile, where each instruction forms a layer.
- This layering makes images lightweight, small, and fast.

Containers:
- A container is a runnable instance of an image.
- Containers can be created, started, stopped, moved, or deleted using the Docker API or CLI.
- They are isolated from other containers and the host machine, though the level of isolation can be controlled.
- Changes to a container’s state are ephemeral unless stored in persistent storage.
```

# Practical

