# Day 13 Challenge: Mastering Docker Volumes for Persistent Applications

Hello Learners,

Welcome back to the DevOps SRE Daily Challenge! 🎉

After exploring Docker networking yesterday, today we’ll focus on Docker Volumes, an essential feature for persisting data across container restarts and enabling data sharing between containers.

By the end of this challenge, you’ll gain a hands-on understanding of how to use Docker volumes to manage stateful applications effectively.



## What Are Docker Volumes?
- Docker volumes are a way to persist data generated and used by Docker containers.
- Unlike bind mounts, volumes are managed by Docker, providing flexibility and enhanced functionality for containerized applications.


## Why Docker Volumes Matter
1. Persistence: Ensures data remains even when containers are stopped or removed.
2. Isolation: Volumes are isolated from the host file system, improving security.
3. Sharing: Easily share data between containers.
4. Backup and Migration: Simplifies data backup and movement between environments.

## Key Docker Volume Commands
- List Volumes: ``` docker volume ls```
- Create a Volume: ``` docker volume create my-volume ```
- Inspect a Volume: ``` docker volume inspect my-volume ```
- Remove a Volume: ``` docker volume rm my-volume ```
- Prune Unused Volumes: ``` docker volume prune ```

## Challenge Steps
1. Persist Data for Yelb Components:
   - Use Docker volumes to persist data for Redis and PostgreSQL.
   - Run PostgreSQL with a Volume
   - Create a volume for PostgreSQL data:
     ``` docker volume create pg-data ```
2. Start the PostgreSQL container with the volume:
  ```
  docker run --name yelb-db \
  --network=yelb-network \
  -v pg-data:/var/lib/postgresql/data \
  -p 5432:5432 \
  -d mreferre/yelb-db:0.6
  ```

3. Run Redis with a Volume:
  - Create a volume for Redis data:
    ``` docker volume create redis-data ```
4. Start the Redis container with the volume:
     ``` 
    docker run --name redis-server \
    --network=yelb-network \
    -v redis-data:/data \
    -p 6379:6379 \
    -d redis:4.0.2
    ```

5. Verify Data Persistence:
  - Stop and remove the Redis and PostgreSQL containers:
    ```
      docker stop redis-server yelb-db
      docker rm redis-server yelb-db
    ```
  - Restart the containers and verify that data is retained:
    ```
    docker run --name yelb-db \
    --network=yelb-network \
    -v pg-data:/var/lib/postgresql/data \
    -p 5432:5432 \
    -d mreferre/yelb-db:0.6
    ```
    
    ```
    docker run --name redis-server \
    --network=yelb-network \
    -v redis-data:/data \
    -p 6379:6379 \
    -d redis:4.0.2
    
6. Inspect Volume Usage
  - Inspect the volumes to confirm they are in use:
    ```
      docker volume inspect pg-data
      docker volume inspect redis-data
    ```

## Submission Guidelines
1. Proof of Completion:
   - Screenshots of the following:
   - Running containers (docker ps).
   - Volume inspection output (docker volume inspect).
   - Redis or PostgreSQL data showing persistence after container restart.
2. Documentation:
   - Steps to set up Docker volumes.
   - Learnings about how Docker volumes work.
   - Challenges faced and how you resolved them.
3. Share Your Progress:
  - Post your experience on social media with the hashtags: #getfitwithsagar, #SRELife, #DevOpsForAll

## Bonus Tasks
- Explore and compare bind mounts with Docker volumes.
- Use docker-compose to define services with volumes.
- Backup and restore data from Docker volumes using docker cp.

## Why This Matters
Understanding Docker volumes is critical for managing stateful applications in production environments. This challenge prepares you to handle real-world scenarios involving data persistence and portability in containerized applications.



If you missed any previous challenges, you can catch up by reviewing the problem statements on GitHub.


Best regards,</br>
Sagar Utekar
