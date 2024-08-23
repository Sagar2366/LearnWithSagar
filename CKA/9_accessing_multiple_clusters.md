# [Organizing Cluster Access Using kubeconfig Files](https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/)
<img src="https://github.com/user-attachments/assets/3cc6b83f-7a12-4a5b-bc0b-d55ff68ec4fc" width="600">

- The kubectl command-line tool uses kubeconfig files to find the information it needs to choose a cluster and communicate with the API server of a cluster.
- By default, kubectl looks for a file named config in the $HOME/.kube directory. You can specify other kubeconfig files by setting the KUBECONFIG environment variable or by setting the --kubeconfig flag.

- The file contains three main sections, clusters, users, and contexts, each with its own specific information:
  1. <b>clusters<b></br>
     Define the Kubernetes cluster being accessed, including the API server URL, certificate authorities, and other cluster-specific details.

  2. <b>users<b></br>
     Provide the authentication details for the existing user or application accessing the Kubernetes cluster. This can include a username and password, client certificates, or authentication tokens.

  3. <b>contexts<b></br>
     Define the environment for the user or application interacting with the Kubernetes cluster.</br>
     It specifies the cluster being accessed, the user credentials being used, and the namespace being targeted.</br>
     Multiple contexts can be defined in the kubeconfig file, allowing for easy switching between different environments or clusters.

 # The loading order follows these rules:

  1.  If the --kubeconfig flag is set, then only that file is loaded. The flag may only be set once and no merging takes
place.</br>
  2.  If $KUBECONFIG environment variable is set, then it is used as a list of paths (normal path delimiting rules for your system).
      These paths are merged. When a value is modified, it is modified in the file that defines the stanza.
      When a value is created, it is created in the first file that exists. If no files in the chain exist, then it creates the last file in the list.
  4.  Otherwise, ${HOME}/.kube/config is used and no merging takes place.</br>
     
   ```
   kubectl config current-context
   kubectl config set-context
   kubectl config use-context
   kubectl config delete-context
   ```
