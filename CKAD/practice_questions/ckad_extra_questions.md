# Rapid Fire

Following is a list of questions that you can time it yourself for practicing the implementation on your local clusters. It will help you speed up your kubectl skills to create the k8s resources that will be handy during the examination.

1. Create a new pod with the NGINX image.
2. Create a new pod with the name 'redis' and with the image 'redis:1.99'.
3. Identify the problem with the pod.
4. Rectify the problem with the pod and wait until the pod is ready and healthy.
5. Create a new replicaset rs-1 using image nginx with labels tier:frontend and selectors as tier:frontend. Create 3 replicas for the same.
6. Scale the replica set above to 5 replicas.
7. Update the image of the above replicaset to use nginx:alpine image.
8. Scale down the replica set to 2 replicas.
9. Create a new deployment deploy-1 using image busybox with 3 replicas and command "sleep 3600".
10. Update the image of the above deployment with image ubuntu.
11. Create a namespace 'finance'.
12. Create a pod redis01 using image redis in 'finance' namespace.
13. Deploy a redis02 pod using the redis:alpine image with the labels set to tier=db.
14. Create a service redis-service to expose the redis02 application within the cluster on port 6379.
15. Create a new pod called custom-nginx using the nginx image and expose it on container port 8080.
16. Create a pod called httpd using the image httpd:alpine in the default namespace. Next, create a service of type ClusterIP by the same name (httpd). The target port for the service should be 80.
17. Create a pod with the ubuntu image to run a container to sleep for 5000 seconds.
18. Create a new ConfigMap for the 'webapp-color' POD. Set key-value pairs as COLOR=blue.
19. Create a deployment nginx01 using nginx image, which has environment variable CREATED_BY with value `octocat`.
20. Verify the environment variable in the containers of the above deployment.
21. Create a new config map db-config with key-value pairs as:
    a] db-host = "localhost.example.com"
    b] db-port = 3306
    c] db-name = "kubernetes-objects"
22. Mount the config map db-config in the deployment ubuntu01 with image ubuntu which has 2 replicas.
23. Create a deployment named multi-con-01, which has two containers, one container uses nginx image and has port 80 exposed. Mount the config map in (21) as environment variables. Create the second container in the same deployment with image ubuntu, keep the container alive using the command `sleep 5000` and mount the config map in (21) with different keys where the new keys are mapped as db-host --> DB_URL, db-port --> DB_PORT, db-name --> DB_NAME.
24. Create an opaque secret named db-creds with following details: db_user=root,db_password=pass404,db_role=admin.
25. Mount the secret db-creds in the deployment multi-con-01 [created in (23)] as environment variables in the ubuntu container with the same keys as mentioned in the secret.
26. Create a pod ubuntu02 with image ubuntu and run the command `sleep 3400` as user 1001.
27. Create a pod ubuntu03 with image ubuntu and add capabilities for SYS_TIME to each container. Run the command `date -s '01JAN 2020 10:00:00' to verify if it is successful.
28. Taint one of the worker nodes in your cluster with the following property, `mode=maintainance:NoSchedule`. Create a pod nginx02 with image nginx:alpine and ensure the pod runs on the tainted node as above.
_Hint: You might want to use tolerations and nodeselectors both in case you have multiple worker nodes._.
29. Create a pod box0 with image busybox and command "sleep 30; touch /tmp/debug; sleep 30; rm /tmp/debug". The pod should not be ready until the file /tmp/debug is available in the pod. If the file doesn't exist, the pod must restart.
30. Create a pod nginx03 with image nginx, make sure the server is up and running every 10 seconds. The nginx server ideally takes 30 seconds to warm up so ensure that there are no false negatives when reporting the health of the pod.
_Note: Nginx runs on port 80._.
31. This is a multistage problem:
    a] Create a deployment deploy01 with image nginx with port 80 exposed.
    b] Update the deployment with image nginx:dev and make sure you record the execution of this action.
    c] If the deployment in step b is unsuccessful, rollback the deployment to the previous state by setting any fields explicitly.
    d] If the nginx deployment is in a healthy state, scale the deployment to run 3 replicas, also record this execution for audit-keeping.
32. Create a job that will roll a dice using image kodekloud/throw-dice. The image generates a random number between 1 and 6 and exits. It is a success only if it is a 6 else it is a failure. Check how many times it takes the job to trigger to get a successful outcome.
33. Create a job with the above image to generate 8 successful outcomes. Also, ensure that the job will attempt no more than 15 attempts and see if the job is successful. You can add an element of 3 parallel executions if required.
34. Create a scheduled job such that it runs every minute. Use the image kodekloud/throw-dice to check the outcome.
35. Create a Persistent Volume `deploy-history` which makes the storage available on each worker nodes at /tmp/deployment. Make sure it has the default provisioner of your cluster assigned. Label the Persistent Volume with `audit: true`, `tier: middleware`. The persistent volume must have a capacity of 2 GB.
36. Create a Persistent Volume `persistent-data` which uses a storage class name `persistent` and is of type hostPath which stores the data on /tmp/persistent on worker nodes. The persistent volume must have a capacity of 2 GB.
37. Create a Persistent Volume `my-personal-data` which uses a storage class name `persistent` and is of type hostPath which stores the data on /tmp/pii on worker nodes. The persistent volume must have a capacity of 2 GB. Since this will store personal data, make sure you can identify the persistent volume using the label "security: high", "type: pii", "audit: true".
38. Create a Persistent Volume Claim to bind to persistent volume which uses storage class `persistent` and needs 2 GB capacity.
39. Create a Persistent Volume Claim to bind to a PV which ensures that the personal and private data is secure. Ensure that this PVC will bind to a PV of type `pii`.
40. Create a PVC such that it will bind to a PV that is qualified for middleware applications.
41. Create a deployment deploy02 with image busybox, mount one of the PVC from above such that it will store logs in the `/tmp/deployment` directory. The containers of the deployment must:
    a] Create a file in /tmp/deployment with the same name as the pod name with .txt extension.
    b] Run the command `i=0; while true; do; echo "$i $(date)" >> /tmp/deployment/<podname>.txt && sleep 60 ; done` to the log file.
    _Hint: You can use init-containers, environment variables to achieve this_.
    c] Ensure there are 5 replicas of the deployment.
    d] Ensure you can see the log files created and populated with data in /tmp/deployment directory on the scheduled worker nodes.
42. Create two deployments i.e. nginx04 and redis04 using images nginx and redis respectively with 3 replicas. Your goal is to ensure that:
    a] each worker node must not have 2 or more nginx04 pods.
    b] each worker node that has a nginx04 pod must have a redis04 pod scheduled on the same node.
    _Hint: Use pod affinity and anti-affinity to ensure the above scneario_.
43. Create 3 pods nginx05, redis05, and httpd05 with images nginx, redis, and httpd respectively. Attach a sidecar debug container of image busybox to each of them. The security team has enforced the application team to limit the communication between unnecessary pods. Ensure that only the following communication is allowed between pods:
    a] Allow: nginx05 and redis05, nginx05 and httpd05.
    b] Deny: httpd05 and redis05, redis05 and rest of the world. nginx05 and the rest of the world.
    Identify a possible information flow in this system. Write the information flow in the format End-User::Pod1::Pod2::Pod3.
44. Create an application stack from this source [link](https://raw.githubusercontent.com/subodh-dharma/ckad/master/resources/network-policy/apps.yaml). Apply a network policy from this source [link](https://raw.githubusercontent.com/subodh-dharma/ckad/master/resources/network-policy/policy.yaml).
    Identify whether the network policy applied is correct or not. If not, update the desired network policy. If any network policy was updated, write the updated policy in /opt/44_netpol.yaml.
45. A developer started a pod calculus with image busybox which performs the calculation "i=0; while true; do a=$(( i*i+i )); echo $a; i=$(( i+1 )); done". But later realized that this is not a reliable way to start a calculation-intensive pod. The developer decided to use a replicaset instead. But with the current pod running it would ruin all the calculations done so far. Can you the developer to ensure that a replicaset can be created and the existing pod can become a part of this replicaset without any downtime. Store the manifest file of the replica set in /opt/45_rs.yaml and at the beginning add a comment describing in one line what strategy was implemented to achieve this.
46. Create a secret named app-secret in the default namespace containing the following single key-value pair: Key3: value1
47. Create a Pod named ngnix secret in the default namespace.Specify a single container using the nginx:stable image.
Add an environment variable named BEST_VARIABLE consuming the value of the secret key3.
48. Fix any API depreciation issues in the manifest file -/credible-mite/www.yaml so that this application can be deployed on cluster K8s. Deploy the application specified in the updated manifest file -/credible-mite/www.yaml in namespace cobra
49. Create a Deployment named expose in the existing ckad00014 namespace running 6 replicas of a Pod. Specify a single container using the ifccncf/nginx: 1.13.7 image
Add an environment variable named NGINX_PORT with the value 8001 to the container then expose port 8001
50. Create a Pod named nginx resources in the existing pod resources namespace.
    Specify a single container using nginx:stable image.
    Specify a resource request of 300m cpus and 1G1 of memory for the Pod's container.
51. First update the Deployment cka00017-deployment in the ckad00017 namespace:
    To run 2 replicas of the pod
    Add the following label on the pod: Role userUI
    Next, Create a NodePort Service named cherry in the ckad00017 namespace exposing the ckad00017-deployment Deployment on TCP port 8888
52. 

