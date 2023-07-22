Kubernetes doesn’t have an API for creating users. Though, it can authenticate and authorize users.

1. Create a client certificate
```
We’ll be creating a key and certificate sign request (CSR) needed to create the certificate. Let’s create a directory where to save the certificates. I’ll call it cert:

$ mkdir cert && cd cert
1.1. Generate a key using OpenSSL:

$ openssl genrsa -out user1.key 2048
1.2. Generate a Client Sign Request (CSR)

$ openssl req -new -key user1.key -out user1.csr -subj “/CN=user1/O=group1”
ls ~/.minikube/ # check that the files ca.crt and ca.key exists in this location.

3. Generate the certificate (CRT)
$ openssl x509 -req -in user1.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out user1.crt -days 500
Now, that we have the .key and the .crt, we can create a user.
```

2. Create a user
```
2.1. Set a user entry in kubeconfig

$ kubectl config set-credentials user1 --client-certificate=user1.crt --client-key=user1.key
2.2. Set a context entry in kubeconfig

$ kubectl config set-context user1-context --cluster=minikube --user=user1
You can check that it is successfully added to kubeconfig:

$ kubectl config view
2.3. Switching to the created user

Now, instead of using the minikube context, we want to use user1-context:

$ kubectl config use-context user1-context
$ kubectl config current-context # check the current context
user1-context
But, now, user1 doesn’t have any access privileges to the cluster. For that we’ll have access denied if we try to create any resource:

$ kubectl create namespace ns-test
Error from server (Forbidden): namespaces is forbidden: User "user1" cannot create resource "namespaces" in API group "" at the cluster scope
```

3. Grant access to the user
```
To give access to manage k8s resources to user1, we need to create a Role and a BindingRole.

3.1. Create a Role

Let’s create a Role object in role.yaml file. The Role will define which resources could be accessed and which operations/verbs could be used.

kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  namespace: default
  name: pod-reader
rules:
- apiGroups: [“”] # “” indicates the core API group
  resources: [“pods”]
  verbs: [“get”, “watch”, “list”]
Resources: pod, deployment, namespace, secret, configmap, service, persistentvolume…

Verbs: get, list, watch, create, delete, update, edit, exec.

3.2. Create a BindingRole

We want to match the User1 to the role created above named : pod-reader. To do that, we need to use RoleBinding.

kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: read-pods
  namespace: default
subjects:
- kind: User
  name: user1 # Name is case sensitive
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role #this must be Role or ClusterRole
  name: pod-reader # must match the name of the Role
  apiGroup: rbac.authorization.k8s.io
  
Deploy both the role.yaml and role-binding.yaml to k8s, and don’t forget to use the context of minikube:

$ kubectl config use-context minikube
Switched to context "minikube".
$ kubectl apply -f role.yaml
role.rbac.authorization.k8s.io/pod-reader created
$ kubectl apply -f role-binding.yaml
rolebinding.rbac.authorization.k8s.io/read-pods created
We check that the Role and BindingRole was created successfully:

$ kubectl get roles
NAME       AGE
pod-reader 2m
$ kubectl get rolebindings
NAME        AGE
read-pods   2m
We used Role to scope the rules to only one namespace, but we can also use ClusterRole to define more than one namespace. RoleBinding is used to bind to Role and ClusterRoleBinding is used to bind to ClusterRole.
```

4. Testing the allowed operations for user
```
Switch again to user1 and try one of the non allowed operations like to create a namespace. This will fail, because user1 is not allowed to do so.

$ kubectl config use-context user1-context
$ kubectl create namespace ns-test # won't succeed, Forbidden
But, when try one of the allowed operations, like getting the pods:

$ kubectl get pods # this will succeed !
```
