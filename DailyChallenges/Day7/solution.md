## Flask app deployment 

### Steps to deploy using python virtual environment:

- Create an EC2 instance with the following details:
  
  - **AMI:** Ubuntu
  - **Instance type:** t2.micro
  - **Volume:** 10GB
--- 
- Update the system
```bash
sudo apt update
```
---
- Install python virtual environment:
```bash
sudo apt install python3-venv
````
---
- Create virtual environment:
```bash
python3 -m venv venv
source venv/bin/activate
```
---
- Clone your source code:
```bash
git clone https://github.com/DevMadhup/flask.git
```
---
- Move to source code directory
```bash
cd flask/examples/tutorial
```
---
- Install the required dependencies:
```bash
pip install -e .
```
---
- Run tests:
```bash
pip install '.[test]'
pytest
```
---
- Initialize database:
```bash
flask --app flaskr init-db
```
---
- Run the application:
```bash
flask --app flaskr run --host=0.0.0.0 --debug
```
> Note: Access the application on http://\<public-ip\>:5000

---
### Steps to deploy using Jenkins & Docker:
- Install docker:
```bash
sudo apt update
sudo apt install docker.io -y
sudo usermod -aG docker $USER && newgrp docker
```
---
- Create a Dockerfile and paste the below content:
```bash
vim Dockerfile
```
```bash
# Use Alpine-based Python image
FROM python:3.12-alpine

# Working directory
WORKDIR /app

# Copy code
COPY . .

# Run Tests
RUN pip install --upgrade flask
RUN pip install '.[test]'
RUN pytest

# Install Dependencies
RUN pip install -e .

# Expose port
EXPOSE 5000

# Run the app
RUN flask --app flaskr init-db
ENTRYPOINT ["flask", "--app", "flaskr", "run", "--host=0.0.0.0", "--debug"]
```
---
- Install Jenkins:
```bash
sudo apt update -y
sudo apt install fontconfig openjdk-17-jre -y

sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
  
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
  
sudo apt-get update -y
sudo apt-get install jenkins -y
```
---
- Access Jenkins from the browser and create a declarative pipeline and paste the below declarative pipeline:
```bash
pipeline{
    agent any
    stages{
        stage("Cleanup Workspace"){
            steps{
                cleanWs()
            }
        }
        
        stage("Clone code"){
            steps{
                git branch: "main", url: "https://github.com/DevMadhup/flask.git" 
            }
        }
        
        stage("Build Docker Image"){
            steps{
                sh "ls -lrt"
                dir("examples/tutorial/"){
                    sh "ls -lrt"
                    sh "docker build -t flaskapp ."
                }
            }
        }
        
        stage("Push Image to DockerHub"){
            steps{
                withCredentials([usernamePassword(credentialsId: 'Docker-cred', passwordVariable: 'DOCKERHUB_PASS', usernameVariable: 'DOCKERHUB_USER')]) {
                    sh "docker login -u $DOCKERHUB_USER -p $DOCKERHUB_PASS"
                    sh "docker tag flaskapp madhupdevops/flaskapp-getfitwithsagar"
                    sh "docker push madhupdevops/flaskapp-getfitwithsagar"
                }
            }
        }
        
        stage("Deploy docker container"){
            steps{
                sh "docker run -itd --name flaskapp -p 5000:5000 madhupdevops/flaskapp-getfitwithsagar"
            }
        }
    }
}
```
---
- Now, run the pipeline and after it get successfull access it on public ip and port 5000
