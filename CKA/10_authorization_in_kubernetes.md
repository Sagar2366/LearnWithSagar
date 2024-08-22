## Controlling access to Kubernetes API
![access-control-overview](https://github.com/user-attachments/assets/9d310cea-e7d3-4ba9-91ec-26a833220d34)


Kubernetes [authorization](https://kubernetes.io/docs/reference/access-authn-authz/authorization/) takes place following authentication.

# Authorization modes 
The Kubernetes API server may authorize a request using one of several authorization modes:

### AlwaysAllow
This mode allows all requests, which brings security risks. Use this authorization mode only if you do not require authorization for your API requests (for example, for testing).

### AlwaysDeny
This mode blocks all requests. Use this authorization mode only for testing.

### ABAC (attribute-based access control)
Kubernetes ABAC mode defines an access control paradigm whereby access rights are granted to users through the use of policies which combine attributes together. The policies can use any type of attributes (user attributes, resource attributes, object, environment attributes, etc).

### RBAC (role-based access control)
Kubernetes RBAC is a method of regulating access to computer or network resources based on the roles of individual users within an enterprise. In this context, access is the ability of an individual user to perform a specific task, such as view, create, or modify a file.
In this mode, Kubernetes uses the rbac.authorization.k8s.io API group to drive authorization decisions, allowing you to dynamically configure permission policies through the Kubernetes API.

### Node
A special-purpose authorization mode that grants permissions to kubelets based on the pods they are scheduled to run. To learn more about the Node authorization mode, see Node Authorization.

### Webhook
Kubernetes webhook mode for authorization makes a synchronous HTTP callout, blocking the request until the remote HTTP service responds to the query.You can write your own software to handle the callout, or use solutions from the ecosystem.


## [Checking API access](https://kubernetes.io/docs/reference/access-authn-authz/authorization/#checking-api-access)
```
kubectl auth can-i create deployments --namespace dev
kubectl auth can-i create deployments --namespace prod
kubectl auth can-i list pods \
    --namespace target \
    --as system:serviceaccount:dev:dev-sa
```


# Using [RBAC](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) Authorization
To enable RBAC, start the API server with the --authorization-mode flag set to a comma-separated list that includes RBAC; for example:
```
kube-apiserver --authorization-mode=Example,RBAC
```

The RBAC API declares four kinds of Kubernetes object: Role, ClusterRole, RoleBinding and ClusterRoleBinding. 

[Command line utilities](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#command-line-utilities)

