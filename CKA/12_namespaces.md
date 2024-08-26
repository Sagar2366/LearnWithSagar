# Namespaces (Virtual sub-clusters) in Kubernetes
In Kubernetes, namespaces provide a mechanism for 
1. Isolating and organising groups of resources within a single cluster
2. Namespaces provide a scope for names. Names of resources need to be unique within a namespace, but not across namespaces.
3. Any number of namespaces are supported within a cluster, each logically separated from others but with the ability to communicate with each other.
4. Namespaces cannot be nested within each other.
5. Namespace-based scoping is applicable only for namespaced objects (e.g. Deployments, Services, etc.) and not for cluster-wide objects (e.g. StorageClass, Nodes, PersistentVolumes, etc.).


## Why do we need namespaces?
1. Multiple teams working on the same application - We can deploy the same application in different namespaces to avoid conflicts of resource names or accidental modification/deletion which can disrupt other team's work.
2. Restricting access: Only authorized users & processes have access to a given resource in the namespace
3. Namespaces are a way to divide cluster resources between multiple users via [resource quota](https://kubernetes.io/docs/concepts/policy/resource-quotas/)
4. Logical grouping of the resources in namespaces: Elasticstack, monitoring, nginx-ingress, database
5. Resource sharing between different environments: blue-green deployment
   

## Initial namespaces
Kubernetes starts with four initial namespaces:
1. default: Kubernetes includes this namespace so that you can start using your new cluster without first creating a namespace.
2. kube-node-lease: This namespace holds Lease objects associated with each node. Node leases allow the kubelet to send heartbeats so that the control plane can detect node failure.
3. kube-public: This namespace is readable by all clients (including those not authenticated). This namespace is mostly reserved for cluster usage, in case that some resources should be visible and readable publicly throughout the whole cluster. The public aspect of this namespace is only a convention, not a requirement.
   eg: A configmap with cluster information data (kubectl cluster-info)
4. kube-system: The namespace for objects created by the Kubernetes system.

# Note: Avoid creating namespaces with the prefix `kube-`, since it is reserved for Kubernetes system namespaces.

# Working with namespaces:

## Imperative method
```
kubectl create namespace dev
kubectl get namespace
kubectl get ns
kubectl describe ns dev
kubectl api-resources | grep namespace
kubectl create namespace test --dry-run=client -o wide > dev-ns.yaml
kubectl get pods
kubectl run nginx --image=nginx -n dev
kubectl run nginx --image=nginx -n dev
kubectl run nginx --image=nginx -n test
kubectl get pods -n dev
kubectl get pod nginx -n dev
kubectl get all -A
kubectl config set-context --current --namespace=dev
kubectl delete ns dev,test

```

## Declarative method
```
apiVersion: v1
kind: Namespace
metadata:
  name: dev
```

## Not all objects are in a namespace
- Most Kubernetes resources (e.g. pods, services, replication controllers, and others) are in some namespaces. 
- However namespace resources are not themselves in a namespace. And low-level resources, such as nodes and persistentVolumes, are not in any namespace.

To see which Kubernetes resources are and aren't in a namespace:

### In a namespace
```
kubectl api-resources --namespaced=true
```

### Not in a namespace
```
kubectl api-resources --namespaced=false
```

## Namespaces and DNS
- When you create a Service, it creates a corresponding DNS entry. This entry is of the form <service-name>.<namespace-name>.svc.cluster.local, which means that if a container only uses <service-name>, it will resolve to the service which is local to a namespace.
- This is useful for using the same configuration across multiple namespaces such as Development, Staging and Production.
- If you want to reach across namespaces, you need to use the fully qualified domain name (FQDN).
- For example, to access the payroll service in the development namespace you would use the address payroll.development and to access the payroll service in the production namespace you would use: payroll.production
  
```
kubectl create deployment kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1
kubectl expose deployment/kubernetes-bootcamp --port 8080
kubectl create deployment kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1 -n prod
kubectl expose deployment/kubernetes-bootcamp --port 8080 -n prod
curl podip
curl svc-name
curl svcname.default.svc.cluster.local
curl svcname.prod.svc.cluster.local
```
