# Pod Creation Process:

1. User Command
- Command Initiation: You issue a command like `kubectl create -f pod.yaml` to create a Pod.

2. kubectl Client
- Command Parsing: The kubectl client parses the command and prepares an HTTP request to the Kubernetes API server.
Authentication and Authorization: The kubectl client uses the kubeconfig file to authenticate against the cluster and verify permissions.
- API Call: The kubectl client sends an HTTP POST request to the Kubernetes API server with the Pod specification from pod.yaml.

3. API Server
- Request Handling: The API server receives the request and processes it. It validates the Pod specification to ensure it’s correctly formatted and that the user has the necessary permissions.
- Validation: The API server validates the incoming request and the Pod configuration against the cluster’s policies.
Accessing etcd
- Data Storage: Once validated, the API server writes the new Pod’s specification to the etcd database, which now stores the desired state of the cluster including the new Pod.
- Status Update: The API server updates the Pod’s status in etcd as it transitions through different states (e.g., Pending, Running).


4. Scheduler
- Pod Assignment: The kube-scheduler detects the new Pod (which initially has no assigned node) and evaluates the available nodes based on resource requirements, affinity rules, and other constraints.
- Node Selection: The scheduler selects an appropriate node and updates the Pod’s specification with the assigned node’s information, which is then saved in etcd.


5. Kubelet
- Pod Creation: The kubelet on the selected node detects the updated Pod specification (from the API server) and starts the process of creating the Pod.
- Container Management: The kubelet interacts with the container runtime (e.g., containerd, CRI-O) to pull the required container images, create the containers, and start them within the Pod.
- Monitoring: The kubelet continuously monitors the Pod and its containers, ensuring they are running correctly and reporting the status back to the API server.

6. kube-proxy
- Networking Setup: The kube-proxy on the node sets up network rules to allow traffic to the new Pod, ensuring that it can communicate with other Pods and external clients according to the service definitions.

7. Final Status:
- The API server updates the Pod’s status in etcd as it transitions through different states (e.g., Pending, Running).
- The kubectl client receives a response from the API server confirming the creation of the Pod and may display information about the newly created Pod.

# Pod Deletion Process:
1. User Command
- Command Initiation: You issue a command like kubectl delete pod <pod-name> to delete a Pod.

2. kubectl Client
- Command Parsing: The kubectl client prepares an HTTP DELETE request to the Kubernetes API server for the specified Pod.
- API Call: The kubectl client sends the HTTP DELETE request to the API server.

3. API Server
- Request Handling: The API server receives the request, validates it, and removes the Pod’s specification from etcd. The Pod’s status is updated to reflect its deletion.

4. Scheduler and Kubelet
- Pod Removal: The kube-scheduler stops considering the Pod for scheduling. The kubelet on the node where the Pod was running cleans up the containers and associated resources.
- Container Cleanup: The container runtime removes the containers associated with the Pod, and kubelet ensures that all resources are freed.

5. kube-proxy
- Networking Cleanup: The kube-proxy updates network rules to remove references to the deleted Pod, ensuring that traffic is no longer routed to it.
API Server

6. Final Status:
- The API server updates the Pod’s status in etcd as "Terminating" and then completely removes its entry once the Pod has been fully cleaned up.
- The kubectl client receives a response confirming the deletion of the Pod and may display a message indicating that the Pod has been successfully deleted.
