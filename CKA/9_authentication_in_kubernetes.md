
# Controlling access to Kubernetes API:
- Users interact with the Kubernetes API through kubectl, client libraries, or by directly making REST requests. 
- Both human users and Kubernetes service accounts can be granted access to the API. 
- When a request is made to the API, it undergoes a series of stages for processing, such as:
  1. Authentication
  2. Authorization
  3. Admission control, and finally, the execution of the request if all checks are passed. 
This structured approach ensures that only authorized requests are processed, maintaining the security and integrity of the Kubernetes cluster.

![access-control-overview](https://github.com/user-attachments/assets/9d310cea-e7d3-4ba9-91ec-26a833220d34)

In Kubernetes, authentication (authn) and authorization (authz) are essential processes to control access to the cluster's resources. 
Certificates (TLS) play a significant role in both of these processes. 

TLS (Transport Layer Security) is integral to securing communication within a Kubernetes cluster, particularly in interactions with the Kubernetes API server. Here's how TLS is implemented and functions within Kubernetes, enhanced with details from your provided information:
![tls-sequence-diagram](https://github.com/user-attachments/assets/d3cb8022-6e10-41c6-bd75-4fcb08e7a3a8)

SSL/TLS Handshake
- Server cert Signed by the CA: CA Sends the certificate with a signature which includes server public key + CA public key
- ClientHello: The client sends a message detailing its supported SSL/TLS versions, ciphersuites, and compression types.
- ServerHello and Certificate Response: The server replies with similar details and provides its certificate signed by the CA. The certificate sent by the server includes the public key for the server, which then client uses in asymmetric encryption.
- Certificate Verification: Client and server agree on TLS version and cipher suite. The client verifies the server's certificate to ensure it's valid and not a man-in-the-middle attack. 
- ClientKeyExchange: Key exchange occurs, such as through the Diffie–Hellman algorithm, to establish a shared secret. Client uses server's public key to encrypt it's own session key and share symmetric encryption key to the server. Now Server can use it's private to decrypt the encrypted session key and encrypted data.
- Finished/Application Data: With the handshake complete and keys exchanged, encrypted communication can begin between the client and server using symmetric cryptography.

1. Kubernetes API Server and TLS
# Port Configuration: 
By default, the Kubernetes API server listens on port 6443 on the first non-localhost network interface, and this communication is protected by TLS. However, in typical production environments, the API server often operates on port 443. The port can be changed using the --secure-port flag, and the specific IP address it listens on can be modified using the --bind-address flag.
Example:

```
kube-apiserver --secure-port=443 --bind-address=0.0.0.0
```

# Certificate Presentation: 
The API server presents a TLS certificate during communication. This certificate can either be signed by a private Certificate Authority (CA) specific to your cluster or by a public CA. The certificate and corresponding private key are specified using the --tls-cert-file and --tls-private-key-file flags.
Example:
```
kube-apiserver --tls-cert-file=/path/to/server.crt --tls-private-key-file=/path/to/server.key
```

2. Private Certificate Authority (CA) Considerations
If your Kubernetes cluster uses a private CA, you'll need to configure the CA certificate on the client-side (e.g., in the ~/.kube/config file). This configuration ensures that the client trusts the API server's certificate, confirming that the connection is secure and not intercepted by an unauthorized entity.
Example kubeconfig:
```
clusters:
- cluster:
    server: https://<api-server>:6443
    certificate-authority: /path/to/ca.crt
  name: my-cluster
```

3. Client Authentication via TLS
During the API server interaction, the client can also present its own TLS client certificate. This certificate is used for client authentication, ensuring that only authorized clients can access the API server. This mutual TLS (mTLS) ensures that both parties in the communication can authenticate each other, enhancing the security of the cluster.
Example:

```
users:
- name: my-user
  user:
    client-certificate: /path/to/client.crt
    client-key: /path/to/client.key
```

Here's how you can grant authentication and authorization using certificates in Kubernetes:

Kubernetes provides a <b>built-in mechanism to sign CSRs using its own CA</b>. This method is often used to create client certificates for service accounts or users within the cluster.

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
