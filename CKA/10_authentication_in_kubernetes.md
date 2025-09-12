# Authentication in Kubernetes

# Controlling access to Kubernetes API:
- Users interact with the Kubernetes API through kubectl, client libraries, or by directly making REST requests. 
- Both human users and Kubernetes service accounts can be granted access to the API. 
- When a request is made to the API, it undergoes a series of stages for processing, such as:
  1. Authentication
  2. Authorization
  3. Admission control, and finally, the execution of the request if all checks are passed. 
</br>
<img src="https://github.com/user-attachments/assets/9d310cea-e7d3-4ba9-91ec-26a833220d34" width="900">
</br></br>

- In Kubernetes, authentication (authn) and authorization (authz) are essential processes to control access to the cluster's resources. 
- Certificates (TLS) play a significant role in both of these processes. 
- TLS (Transport Layer Security) is integral to securing communication within a Kubernetes cluster, particularly in interactions with the Kubernetes API server.

<img src="https://github.com/user-attachments/assets/d3cb8022-6e10-41c6-bd75-4fcb08e7a3a8" width="400">        <img src="https://github.com/user-attachments/assets/a5787aed-c189-4855-a833-496cd10a2f72" width="400" height="440">


SSL/TLS Handshake in general
- Server cert Signed by the CA: CA Sends the certificate with a signature which includes server public key + CA public key
- ClientHello: The client sends a message detailing its supported SSL/TLS versions, ciphersuites, and compression types.
- ServerHello and Certificate Response: The server replies with similar details and provides its certificate signed by the CA. The certificate sent by the server includes the public key for the server, which then client uses in asymmetric encryption.
- Certificate Verification: Client and server agree on TLS version and cipher suite. The client verifies the server's certificate to ensure it's valid and not a man-in-the-middle attack. 
- ClientKeyExchange: Key exchange occurs, such as through the Diffie–Hellman algorithm, to establish a shared secret. Client uses server's public key to encrypt it's own session key and share symmetric encryption key to the server. Now Server can use it's private to decrypt the encrypted session key and encrypted data.
- Finished/Application Data: With the handshake complete and keys exchanged, encrypted communication can begin between the client and server using symmetric cryptography.


# Client-server communication in Kubernetes:
By default, the Kubernetes API server listens on port 6443 on the first non-localhost network interface, and this communication is protected by TLS.
# Certificate Presentation: 
The API server presents a TLS certificate during communication. This certificate can either be signed by a private Certificate Authority (CA) specific to your cluster or by a public CA. 
Example:
```
kube-apiserver --tls-cert-file=/path/to/server.crt --tls-private-key-file=/path/to/server.key
```

# Client Authentication via TLS
Even though a normal user cannot be added via an API call, any user that presents a valid certificate signed by the cluster's certificate authority (CA) is considered authenticated.
During the API server interaction, the client can also present its own TLS client certificate. This certificate is used for client authentication, ensuring that only authorized clients can access the API server. This mutual TLS (mTLS) ensures that both parties in the communication can authenticate each other, enhancing the security of the cluster.
Example:

```
users:
- name: my-user
  user:
    client-certificate: /path/to/client.crt
    client-key: /path/to/client.key
```

# Authentication strategies
1. X509 client certificates
2. Static token file
3. Bootstrap tokens
4. Service account tokens
5. OpenID Connect tokens
6. Webhook Token Authentication
7. Anonymous requests


# [How to issue a certificate for a user](https://kubernetes.io/docs/reference/access-authn-authz/certificate-signing-requests/#normal-user):
Here's how you can grant authentication and authorization using X509 certificates created using [openssl](https://kubernetes.io/docs/tasks/administer-cluster/certificates/#openssl) in Kubernetes:

Kubernetes provides a <b>built-in mechanism to sign CSRs using its own CA</b>. This method is often used to create client certificates for service accounts or users within the cluster.

# Generate the CSR and Private Key
```
openssl genrsa -out myuser.key 2048
openssl req -new -key myuser.key -out myuser.csr -subj "/CN=myuser"
```

# Create a CSR Object in Kubernetes
Encode the CSR with base64 format
```
$(cat myuser.csr | base64 | tr -d '\n')
```

The CSR is then submitted to Kubernetes as a CSR resource object.
```
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: myuser
spec:
  request: <<BASE64_ENCODED_CSR>>
  signerName: kubernetes.io/kube-apiserver-client
  expirationSeconds: 86400
  usages:
  - client auth
  - digital signature
  groups:
  - system:authenticated
```

You can apply this CSR resource using kubectl:
```
kubectl get csr
kubectl apply -f csr.yaml
```

# Approve the CSR
Once the CSR resource is created, a cluster administrator needs to approve the CSR for it to be signed by the Kubernetes CA.
```
kubectl certificate approve myuser
```

# Retrieve the Signed Certificate
After approval, the CSR object will have the signed certificate included in its status. You can extract the certificate from the CSR object:
```
kubectl get csr myuser -o jsonpath='{.status.certificate}' | base64 --decode > myuser.crt
```

# Create role and rolebinding
This is a sample command to create a Role for this new user:
```
kubectl create role developer --verb=create --verb=get --verb=list --verb=update --verb=delete --resource=pods
```

This is a sample command to create a RoleBinding for this new user:
```
kubectl create rolebinding developer-binding-myuser --role=developer --user=myuser
```

# Configure the Client
The signed certificate (user.crt) and the private key (user.key) are then configured in the client’s kubeconfig file, allowing the user to authenticate with the Kubernetes API server.
```
# In kubeconfig
users:
- name: username
  user:
    client-certificate: /path/to/myuser.crt
    client-key: /path/to/myuser.key
```
or
```
kubectl config set-credentials myuser --client-key=myuser.key --client-certificate=myuser.crt --embed-certs=true
```

Then, you need to add the context:
```
kubectl config set-context myuser --cluster=kubernetes --user=myuser
```

To test it, change the context to myuser:
```
kubectl config use-context myuser
```
