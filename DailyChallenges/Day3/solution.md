```
1. Core Concepts
Client: Requests a service (e.g., browser accessing a website).

Server: Responds to requests (e.g., Google’s servers).

Proxy: Acts as an intermediary.

Forward Proxy: Sits on the client side (e.g., corporate VPNs to monitor employee internet access).

Reverse Proxy: Sits on the server side (e.g., Nginx routing traffic to backend services like Grafana/Jenkins).

Load Balancer: Distributes traffic across servers (e.g., AWS ALB/NLB).

2. Why Nginx?
Reverse Proxy + Load Balancing: Routes requests to multiple backend services.

Security: SSL/TLS termination, IP whitelisting, rate limiting.

Performance: Caching static content, reducing server load.
```


## Launch EC2 Instances
- Create Two EC2 Instances  - One for Grafana, One for Jenkins.
- Open required ports in the EC2 security group:
- Grafana: Port 3000.
- Jenkins: Port 8080.
- Nginx: Ports 80 and 443.

## Update the system and install necessary packages on both instances:
```
sudo apt update && sudo apt upgrade -y 
```

### Install Grafana on the Grafana EC2 instance:
```
sudo apt-get install -y apt-transport-https software-properties-common wget
sudo mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com beta main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
# Updates the list of available packages
sudo apt-get update
sudo apt-get install -y grafana
sudo systemctl start grafana-server
sudo systemctl enable grafana-server
sudo systemctl status grafana-server
```
Official Doc for Grafana Installation: https://grafana.com/grafana/download?edition=oss

## Install Java & Jenkins
```
Downloading and installing Jenkins
Completing the previous steps enables you to download and install Jenkins on AWS. To download and install Jenkins:

Ensure that your software packages are up to date on your instance by using the following command to perform a quick software update:

[ec2-user ~]$ sudo yum update –y
Add the Jenkins repo using the following command:

[ec2-user ~]$ sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
Import a key file from Jenkins-CI to enable installation from the package:

[ec2-user ~]$ sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
[ec2-user ~]$ sudo yum upgrade
Install Java (Amazon Linux 2023):

[ec2-user ~]$ sudo dnf install java-17-amazon-corretto -y
Install Jenkins:

[ec2-user ~]$ sudo yum install jenkins -y
Enable the Jenkins service to start at boot:

[ec2-user ~]$ sudo systemctl enable jenkins
Start Jenkins as a service:

[ec2-user ~]$ sudo systemctl start jenkins
You can check the status of the Jenkins service using the command:

[ec2-user ~]$ sudo systemctl status jenkins

```
Official Doc for Jenkins Installation: https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS/#prerequisites

### Install and Configure Nginx as a Reverse Proxy
- Install Nginx on one EC2 instance (e.g., Grafana EC2): ```sudo apt-get install -y nginx```
- Configure Nginx: Edit the Nginx configuration file:
```
sudo nano /etc/nginx/sites-available/default
Replace the file contents with:

nginx
Copy code
server {
    listen 80;
    server_name grafana.local jenkins.local;

    # Redirect HTTP to HTTPS
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl;
    server_name grafana.local;

    ssl_certificate /etc/nginx/ssl/server.crt;
    ssl_certificate_key /etc/nginx/ssl/server.key;

    location / {
        proxy_pass http://<GRAFANA_EC2_PRIVATE_IP>:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}

server {
    listen 443 ssl;
    server_name jenkins.local;

    ssl_certificate /etc/nginx/ssl/server.crt;
    ssl_certificate_key /etc/nginx/ssl/server.key;

    auth_basic "Restricted Access";
    auth_basic_user_file /etc/nginx/.htpasswd;

    location / {
        proxy_pass http://<JENKINS_EC2_PRIVATE_IP>:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

- Generate a self-signed SSL certificate:
```
sudo mkdir /etc/nginx/ssl
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.crt
```
- Create a .htpasswd file for Jenkins basic authentication:
```
sudo apt-get install -y apache2-utils
sudo htpasswd -c /etc/nginx/.htpasswd admin
```

- Test and restart Nginx:
```
sudo nginx -t
sudo systemctl restart nginx
```

### Validate Configuration
- Update your local system's /etc/hosts file to resolve domains:
```
<NGINX_EC2_PUBLIC_IP> grafana.local
<NGINX_EC2_PUBLIC_IP> jenkins.local
```
- Open a browser and verify:
```
Access Grafana: https://grafana.local
Access Jenkins: https://jenkins.local (use credentials set in .htpasswd).
Ensure HTTP redirects to HTTPS.
```


