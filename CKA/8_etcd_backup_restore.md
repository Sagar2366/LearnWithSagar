# ETCD Backup and restore
- Kubernetes Documenation link: https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/
- etcd v3.6.0 Documentation: https://etcd.io/docs/v3.6/op-guide/recovery/#restoring-a-cluster
- etcd v3.5 Documentation: https://etcd.io/docs/v3.5/op-guide/security/

## Which application version is running in [CKA Exam environment](https://docs.linuxfoundation.org/tc-docs/certification/faq-cka-ckad-cks#what-application-version-is-running-in-the-exam-environment)?
![Screenshot 2024-08-21 at 8 14 06 AM](https://github.com/user-attachments/assets/312f5275-270a-4e72-a112-1fd72da3b0f9)


# What is etcd?
- Etcd is a consistent and highly-available key-value store used as the backing database for all Kubernetes cluster data, including information about Pods, nodes, and networking configurations.
- All updates to etcd are routed through the kube-apiserver, which handles simultaneous requests sequentially, ensuring consistency.
- It's crucial to have a backup plan for the data stored in etcd, given its importance in maintaining the cluster's state.
Port: 2379-2380
Check etcd pod
```
kubectl get pods -n kube-system | grep -i etcd
kubectl exec -it <kube-scheduler-pod-id> -- cat /etc/kubernetes/manifests/etcd.yaml | grep file
```


# Starting etcd cluster
1. single node etcd cluster: Use a single-node etcd cluster only for testing purposes.
2. Multinode etcd cluster: For durability and high availability, run etcd as a multi-node cluster in production and back it up periodically.
   A five-member cluster is recommended in production.
3. Multinode etcd cluster with loadbalancer

# How to install etcd v3.5 or latest on your Kubernetes cluster?
```
export RELEASE=$(curl -s https://api.github.com/repos/etcd-io/etcd/releases/latest|grep tag_name | cut -d '"' -f 4)
wget https://github.com/etcd-io/etcd/releases/download/${RELEASE}/etcd-${RELEASE}-linux-amd64.tar.gz
tar xvf etcd-${RELEASE}-linux-amd64.tar.gz
cd etcd-${RELEASE}-linux-amd64
sudo mv etcd etcdctl etcdutl /usr/local/bin 
etcd --version
etcdctl version
etcdutl version
```

# Securing etcd cluster
- Access to etcd is equivalent to root permission in the cluster so ideally only the API server should have access to it.
- Considering the sensitivity of the data, it is recommended to grant permission to only those nodes that require access to etcd clusters.
- To configure etcd with secure peer communication, specify flags --peer-key-file=peer.key and --peer-cert-file=peer.cert, and use HTTPS as the URL schema.
- Similarly, to configure etcd with secure client communication, specify flags --key-file=k8sclient.key and --cert-file=k8sclient.cert, and use HTTPS as the URL schema. Here is an example on a client command that uses secure communication:
```
ETCDCTL_API=3 etcdctl --endpoints 127.0.0.1:2379 \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  member list
```

# Backing up etcd cluster
<b>Note:</b> where trusted-ca-file, cert-file and key-file can be obtained from the description of the etcd Pod.
```
ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 \
                      --cacert=<trusted-ca-file>
                      --cert=<cert-file>
                      --key=<key-file> \
                      snapshot save snapshot.db

```

# Verify the snapshot
1. Using etcdctl:
<b>Note:</b> where trusted-ca-file, cert-file and key-file can be obtained from the description of the etcd Pod.
```
ETCDCTL_API=3 etcdctl --write-out=table --endpoints=https://127.0.0.1:2379 \
                      --cacert=<trusted-ca-file>
                      --cert=<cert-file>
                      --key=<key-file> \
                      snapshot status snapshot.db 

```
2. Using etcdutl:
   ```
   etcdutl --write-out=table snapshot status snapshot.db 
   ```

# Restoring etcd cluster
<b>Caution:</b>
- If any API servers are running in your cluster, you should not attempt to restore instances of etcd. Instead, follow these steps to restore etcd:
```
stop all API server instances
restore state in all etcd instances
restart all API server instances
The Kubernetes project also recommends restarting Kubernetes components (kube-scheduler, kube-controller-manager, kubelet) to ensure that they don't rely on some stale data. In practice the restore takes a bit of time. During the restoration, critical components will lose leader lock and restart themselves.
```

1. Using etcdctl
<b>Note:</b> where trusted-ca-file, cert-file and key-file can be obtained from the description of the etcd Pod.
```
ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 \
                      --cacert=<trusted-ca-file>
                      --cert=<cert-file>
                      --key=<key-file> \
                      --data-dir <data-dir-location> snapshot restore snapshot.db

```
- If <data-dir-location> is the same folder as before, delete it and stop the etcd process before restoring the cluster. 
- Otherwise, change etcd configuration and restart the etcd process after restoration to have it use the new data directory: first change /etc/kubernetes/manifests/etcd.yaml's volumes.hostPath.path for name: etcd-data to <data-dir-location>, then execute kubectl -n kube-system delete pod <name-of-etcd-pod> or systemctl restart kubelet.service (or both).

2. Using etcdutl:
When restoring the cluster using etcdutl, use the --data-dir option to specify to which folder the cluster should be restored:
```
etcdutl --data-dir <data-dir-location> snapshot restore snapshot.db
```
where <data-dir-location> is a directory that will be created during the restore process.


# Verify the cluster state
```
kubectl get pods -A
kubectl get nodes
```
