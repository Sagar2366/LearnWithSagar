
In Kubernetes, authentication (authn) and authorization (authz) are essential processes to control access to the cluster's resources. 
Certificates (TLS) play a significant role in both of these processes. Here's how you can grant authentication and authorization using certificates in Kubernetes:

Kubernetes provides a built-in mechanism to sign CSRs using its own CA. This method is often used to create client certificates for service accounts or users within the cluster.

# Generate the CSR and Private Key
```
openssl genrsa -out user.key 2048
openssl req -new -key user.key -out user.csr -subj "/CN=username/O=group"
```

# Create a CSR Object in Kubernetes
The CSR is then submitted to Kubernetes as a CSR resource object.
```
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: username-csr
spec:
  request: $(cat user.csr | base64 | tr -d '\n')
  signerName: kubernetes.io/kube-apiserver-client
  usages:
  - client auth
  - digital signature
  groups:
  - system:authenticated
```

You can apply this CSR resource using kubectl:
```
kubectl apply -f csr.yaml
```

# Approve the CSR
Once the CSR resource is created, a cluster administrator needs to approve the CSR for it to be signed by the Kubernetes CA.
```
kubectl certificate approve username-csr
```

# Retrieve the Signed Certificate
After approval, the CSR object will have the signed certificate included in its status. You can extract the certificate from the CSR object:
```
kubectl get csr username-csr -o jsonpath='{.status.certificate}' | base64 --decode > user.crt
```

# Configure the Client
The signed certificate (user.crt) and the private key (user.key) are then configured in the client’s kubeconfig file, allowing the user to authenticate with the Kubernetes API server.
```
# In kubeconfig
users:
- name: username
  user:
    client-certificate: /path/to/user.crt
    client-key: /path/to/user.key
```
