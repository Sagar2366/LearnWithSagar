
<h1> What happens when you create or delete a Deployment in Kubernetes</h1>

# Deployment Creation Process

1. User Command
- Command Initiation: You issue a command like kubectl create -f deployment.yaml to create a Deployment.

2. kubectl Client
- Command Parsing: The kubectl client parses the command and prepares an HTTP request to the Kubernetes API server.
- Authentication and Authorization: The kubectl client uses the kubeconfig file to authenticate against the cluster and determine your permissions.
- API Call: The kubectl client sends an HTTP POST request to the Kubernetes API server with the Deployment specification from deployment.yaml.


3. API Server
- Request Handling: The API server receives and processes the request. It validates the Deployment specification to ensure it follows the correct format and checks permissions.
- Validation: The API server verifies that the Deployment configuration is valid and adheres to cluster policies.
- Accessing etcd Data Storage: The API server writes the new Deployment specification to the etcd database, which stores the desired state of the cluster, including the new Deployment.

4. Controller Manager
- Deployment Controller: The Deployment controller within the kube-controller-manager detects the new Deployment. It ensures that the desired number of Pods (as specified in the Deployment) are created and running.
- ReplicaSet Creation: The Deployment controller creates a ReplicaSet to manage the Pods. The ReplicaSet is responsible for maintaining the specified number of Pod replicas.

5. Scheduler
- Pod Assignment: The kube-scheduler detects the Pods created by the ReplicaSet and evaluates available nodes based on resource requirements and constraints.
- Node Selection: The scheduler selects appropriate nodes and assigns the Pods to them.

6. Kubelet
- Pod Creation: The kubelet on the selected nodes detects the new Pods and starts the process of creating them.
- Container Management: The kubelet interacts with the container runtime to pull images, create containers, and start them.

7. kube-proxy
- Networking Setup: The kube-proxy on each node updates network rules to ensure that the newly created Pods can communicate with other Pods and services.

8. Deployment Running
- Monitoring: The kubelet and ReplicaSet controller continuously monitor the Pods to ensure they are running as expected. If any Pods fail, they are replaced by new ones.
API Server
- Status Update: The API server updates the status of the Deployment and its Pods in etcd as they transition through various states (e.g., Pending, Running).
kubectl Client
- Confirmation: The kubectl client receives a response from the API server confirming the creation of the Deployment and displays information about the Deployment and its Pods.


# Deployment Deletion Process

1. User Command
- Command Initiation: You issue a command like kubectl delete deployment <deployment-name> to delete a Deployment.

2. kubectl Client
- Command Parsing: The kubectl client prepares an HTTP DELETE request to the Kubernetes API server for the specified Deployment.
- API Call: The kubectl client sends the HTTP DELETE request to the API server.

3. API Server
- Request Handling: The API server receives the request, validates it, and updates the Deployment’s status to indicate it is being deleted. The Deployment and its associated ReplicaSet are marked for deletion.

4. Controller Manager
- Deployment Controller: The Deployment controller detects the deletion request and starts cleaning up the resources. It deletes the ReplicaSet created for the Deployment.
- Pod Deletion: The ReplicaSet controller ensures that the Pods managed by the ReplicaSet are also deleted.

5. Scheduler and Kubelet
- Pod Cleanup: The kube-scheduler stops scheduling Pods from the deleted ReplicaSet. The kubelet on the nodes where the Pods were running cleans up the containers and resources.
- Container Removal: The container runtime removes the containers associated with the Pods, and the kubelet ensures resources are freed.

6. kube-proxy
- Networking Cleanup: The kube-proxy updates network rules to remove references to the deleted Pods, ensuring traffic is no longer routed to them.


7. Final Status:
- The API server updates the Deployment’s status in etcd as "Terminating" and eventually removes its entry once the Deployment and all associated resources are fully cleaned up.
- Confirmation: The kubectl client receives a response confirming the deletion of the Deployment and displays a message indicating that the Deployment has been successfully deleted.
