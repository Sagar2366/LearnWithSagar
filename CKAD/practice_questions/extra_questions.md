# Day 4 - Practice Questions


```
1. Create a new file Dockerfile to build a container image from. It should:
    use bash as base
    run ping google.com
    Build the image and tag it as pinger.
    Run the image (create a container) named my-ping.

2. Tag the image, which is currently tagged as pinger , also as local-registry:5000/pinger .

3. Create a namespace called 'mynamespace' and a pod with image nginx in mynamespace

4. Create a busybox pod (using YAML) that runs the command "env".

5. Get the YAML for a new namespace called 'myns' without creating it

6. Get pods on all namespaces

7. Get information about the pod, including details about potential issues (e.g. pod hasn't started)

8. Create a busybox pod that echoes 'hello world' and then exits

9. Delete the pod you just created without any delay (force delete)

10. Create the nginx pod with version 1.17.4 and expose it on port 80
    
11. Change the Image version to 1.15-alpine for the pod you just created and verify the image version is updated

12. Change the Image version back to 1.17.1 for the pod you just updated and observe the changes

13. Create a Pod with three busy box containers with commands “ls; sleep 3600;”, “echo Hello World; sleep 3600;” and “echo this is the third container; sleep 3600” respectively and check the status

14. Show metrics of the above pod containers and puts them into the file.log and verify

15. Create a Docker file and save the file in directory /opt/ldh/Question12
    The Docker file run an alpine image with the command "echo hello linuxdatahub" as the default command. 
    Build the image, and export it in OCI format to a file file with the name "linuxdocker" and tag should be 9.8. 
    Use sudo wherever required.

16. Create a container from the attached Dockerfile and index.html.
    Name the image my-image.
    Run the container exposing port 8080 on the host and port 80 on the container.
    Name the container my-container. 
    Stop the container. 
    Delete the container.
    Save image in tar file format.


```
