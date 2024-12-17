# Day17 Challenge: Docker Essentials - Your First Step to CKA Success

Hello Learners,



Welcome back to the DevOps SRE Daily Challenge! 🎉



Welcome to today's challenge! Today, we’ll focus on Container Fundamentals crucial for the CKA exam. Understanding these concepts is essential for deploying, managing, and troubleshooting containerized applications.

### What You'll Learn:
- The evolution of application deployment methods.
- Core principles of containerization.
- Key features and advantages of Docker.

## Challenge Tasks
## Theory Refresher
- Could you explain in your own words the difference between virtual machines and containers?
- Why are containers considered lightweight compared to VMs?
- Explain Docker Architecture
- What are Docker's key components (e.g., images, containers, registries)?

## Hands-On Practice
- Install Docker on your local machine or a virtual instance (if not already installed).
- Run the official nginx Docker container:
``` docker run -d -p 8080:80 nginx ```
- Access the running container via your browser at http://<your-ip>:8080.
- Please list all running containers and look over the nginx container details.

## Deep Dive Exercise
- Create a Dockerfile for a simple Python application that prints "Hello, Containers!" when run.
- Build an image from your Dockerfile and run it as a container.
- Share your Dockerfile and the output of the container in your submission.
- Share your Docker image
- Tag the Docker image you created for the Python application. Use the format: <your-dockerhub-username>/<image-name>:<tag>
  Example:
  ``` docker tag python-hello <your-dockerhub-username>/python-hello:v1 ```
- Push the tagged image to Docker Hub (or any container registry you prefer)
  ``` docker push <your-dockerhub-username>/python-hello:v1```
- Share the public URL of your pushed image in the submission.

## Submission Guidelines
- Write your responses in markdown or text format.
- Include screenshots of your running container and Dockerfile output for verification.
- Post your experience on social media with the hashtags: #getfitwithsagar, #SRELife, #DevOpsForAll #ckawithsagar


## Resources to Help You:
- Container Fundamentals
- Docker documentation
- Docker Tutorial for Beginners (YouTube)


Good luck, and remember, mastering these basics is your first step toward acing the CKA exam! 🚀


If you missed any previous challenges, you can catch up by reviewing the problem statements on GitHub.


Best regards,</br>
Sagar Utekar
