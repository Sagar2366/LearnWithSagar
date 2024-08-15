

## What is Containerd?
- containerd is an open-source container runtime designed to manage and run containers by leveraging operating system kernel features.
- It simplifies container management by providing an abstraction layer that handles namespaces, cgroups, union file systems,
  networking, and more, so developers don't need to manage these complexities directly.

<b>Key Points:</b>
1. History and Evolution:
   - In March 2017, Docker extracted its core container runtime into a standalone project called containerd and donated it to the Cloud Native Computing Foundation (CNCF).
   - By February 2019, containerd reached the Graduated maturity level within the CNCF, indicating its widespread adoption and robust community support.

2. Industry Standard:
   - containerd is recognized as an industry-standard container runtime, valued for its scalability, performance, and stability.
   - It's suitable for a range of use cases, from small-scale deployments to large enterprise environments, including Kubernetes.

3. OCI Compliance:
   - containerd uses Open Container Initiative (OCI)-compliant runtimes, such as runc, ensuring standardization and interoperability across containerized environments.
   - It efficiently manages core container lifecycle operations, including creating, starting, and stopping containers.

  
## How Docker interacts with Containerd?
![containerd-diagram-v1](https://github.com/user-attachments/assets/873c08cc-6892-4388-ba43-d07e81017066)

To better understand this interaction, let’s talk about what happens when you run the docker run command:

1. After you select enter, the Docker CLI will send the run command and any command-line arguments to the Docker daemon (dockerd) via REST API call.
2. dockerd will parse and validate the request, and then it will check that things like container images are available locally. If they’re not, it will pull the image from the specified registry.
3. Once the image is ready, dockerd will shift control to containerd to create the container from the image.
4. Next, containerd will set up the container environment. This process includes tasks such as setting up the container file system, networking interfaces, and other isolation features.
5. containerd will then delegate running the container to runc using a shim process. This will create and start the container.
6. Finally, once the container is running, containerd will monitor the container status and manage the lifecycle accordingly.


## What is difference between runc and Containerd?
<b>runc</b>
- runc is a container runtime that offers a low-level interface for creating and running containers in accordance with the Open Container Initiative (OCI) specification.
- It is designed to be lightweight and secure, making it easy to integrate with higher-level container orchestration systems like Kubernetes.

<b>containerd</b>
- containerd is a higher-level container runtime that provides a comprehensive environment for managing containers.
- This includes image management, container execution, and lifecycle management.
- It is robust and extensible, making it suitable for use in various container orchestration systems.

<b>Key Differences:</b>
```
runc: Provides the essential functionality for creating and running containers.
containerd: Offers a complete environment for managing and orchestrating container workloads,
            building on top of runc for more advanced management features.
```

## What is OCI?
- OCI stands for the Open Container Initiative, which standardized many of the interfaces between container tools and technologies.
- They maintain a standard specification for packaging container images (OCI image-spec) and running containers (OCI runtime-spec).
- They also maintain an actual implementation of the runtime-spec in the form of runc, which is the underlying default runtime for both containerd and CRI-O.
- The CRI builds on these low-level specifications to provide an end-to-end standard for managing containers.

