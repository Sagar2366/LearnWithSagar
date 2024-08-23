# [Organizing Cluster Access Using kubeconfig Files](https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/)

- Use kubeconfig files to organize information about clusters, users, namespaces, and authentication mechanisms.
- The kubectl command-line tool uses kubeconfig files to find the information it needs to choose a cluster and communicate with the API server of a cluster.
- By default, kubectl looks for a file named config in the $HOME/.kube directory. You can specify other kubeconfig files by setting the KUBECONFIG environment variable or by setting the --kubeconfig flag.

Kubeconfig File stores information aboutL
1. certificate-authority-data: Cluster CA
2. server: Cluster endpoint (IP/DNS of the controlplane node)
3. name: Cluster name
4. user: name of the user/service account.
5. User Client certificates and client-key-data
6. token: Secret token of the user/service account.
7. Context: Combines a cluster and user into a specific working environment

 The loading order follows these rules:

  1.  If the --kubeconfig flag is set, then only that file is loaded. The flag may only be set once and no merging takes
place.
  2.  If $KUBECONFIG environment variable is set, then it is used as a list of paths (normal path delimiting rules for
your system). These paths are merged. When a value is modified, it is modified in the file that defines the stanza. When
a value is created, it is created in the first file that exists. If no files in the chain exist, then it creates the
last file in the list.
  3.  Otherwise, ${HOME}/.kube/config is used and no merging takes place.
     
   ```
   kubectl config current-context
   kubectl config set-context
   kubectl config use-context
   kubectl config delete-context
   ```
