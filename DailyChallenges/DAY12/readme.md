# Day 12 Challenge - Deploying Yelb application with Docker to understand Docker networking

Hello Learners,


Welcome back to the DevOps SRE Daily Challenge! 🎉


Today’s challenge focuses on Docker Networking, a fundamental concept for deploying and managing multi-container applications.</br> 
To make this practical, we’ll deploy Yelb, a multi-service demo application, while highlighting Docker networking capabilities.

By the end of this challenge, you’ll have a hands-on understanding of connecting containers using Docker's networking features and managing a multi-container application effectively.



## What is Docker Networking?
Docker networking enables communication between containers, the host, and external systems. 
It’s crucial for connecting services in a multi-container environment, ensuring seamless communication.



## Key Features of Docker Networking:
- Isolation: Containers communicate only when allowed, ensuring security.
- Name Resolution: Containers on a user-defined bridge network can resolve each other by name.
- Customizability: Networks can be configured for specific requirements, such as isolation or external access.

## Key Docker Networking Commands
  - List Networks: ``` docker network ls ```
  - Inspect a Network: ``` docker network inspect yelb-network ```
  - Connect a Running Container to a Network:  ``` docker network connect yelb-network <container_name> ```

## Types of Docker Networks
  - Bridge (Default): For standalone containers; supports user-defined configurations.
  - Host: Shares the host's network stack. Ideal for high-performance scenarios.
  - Overlay: Connects containers across multiple Docker hosts.

Steps to Complete the Challenge
1. Create a Docker Network:
  - Start by creating a user-defined bridge network for container communication.
    ``` docker network create yelb-network ```
2. Run the Redis Server
  - Deploy Redis, which acts as a caching layer to store page views.
```
docker run --name redis-server \
  --network=yelb-network \
  -p 6379:6379 \
  -d redis:4.0.2
```
3. Run the PostgreSQL Database:
  - Start PostgreSQL to store persistent vote data.
```
docker run --name yelb-db \
  --network=yelb-network \
  -p 5432:5432 \
  -d mreferre/yelb-db:0.6
```
4. Run the Yelb Appserver:
  - Launch the application server, ensuring it connects to Redis and PostgreSQL.

```
docker run --name yelb-appserver \
  --network=yelb-network \
  -d -p 4567:4567 \
  -e RACK_ENV=test \
  mreferre/yelb-appserver:0.7
```
5. Run the Yelb UI:
  - Deploy the front-end, connecting it to the app server, and expose it for user access.
```
docker run --name yelb-ui \
  --network=yelb-network \
  -d -p 8080:80 \
  -e UI_ENV=test \
  mreferre/yelb-ui:0.10
```
6. Test the Application:
  - Open your browser and visit http://localhost:8080.
  - Interact with the Yelb UI to confirm all services are working correctly.

## Troubleshooting Tips
1. Service Not Accessible:
   - Check if the containers are running using docker ps.
   - Inspect container logs using docker logs <container_name> for errors.
2. Containers Cannot Communicate:
   - Verify the network with docker network inspect yelb-network. Ensure all containers are connected.
   - Reconnect a container to the network: ``` docker network connect yelb-network <container_name>```
3. Port Conflict:
   - If a port is already in use, map the container to an available port. For example:  ``` docker run -d -p 8081:80 <image_name>```
4. Environment Variable Errors:
   - Verify that required environment variables (RACK_ENV and UI_ENV) are set.
   - If incorrect, stop the container, remove it, and restart with the correct variables.

## Cleanup Steps
1. Stop and Remove Containers:
  ```
    docker stop redis-server yelb-db yelb-appserver yelb-ui
    docker rm redis-server yelb-db yelb-appserver yelb-ui
  ```
2. Remove the Docker Network:  ``` docker network rm yelb-network ```
3. Remove Unused Docker Images (Optional): ``` docker image prune -a ```
 
## Submission Guidelines
1. Proof of Completion:
   - Screenshot of docker ps showing all running Yelb containers.
   - Screenshot of the Yelb UI in the browser.
   - Output from docker network inspect yelb-network showing container connectivity.
2. Documentation:
   - Steps to deploy Yelb manually.
   - Insights into how Docker networking facilitated communication between containers.
   - Key challenges faced and solutions.
3. Share Your Progress:
   - Post your experience on social media with the hashtags: #getfitwithsagar, #SRELife, #DevOpsForAll

## Bonus Tasks:
- Use Docker volumes to persist Redis and PostgreSQL data.
- Push the custom Yelb images to a container registry (ECR, GCR, or ACR).

## Why This Matters
- Understanding Docker networking is crucial for deploying containerized applications efficiently.
- This challenge bridges the gap between theory and practice by deploying a real-world application and leveraging Docker's networking capabilities.



If you missed any previous challenges, you can catch up by reviewing the problem statements on GitHub.


Best regards,</br>
Sagar Utekar
