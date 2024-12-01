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

## Install Java
```
sudo apt update
sudo apt install fontconfig openjdk-17-jre
java -version
openjdk version "17.0.8" 2023-07-18
```

### Install Jenkins on the Jenkins EC2 instance:
```
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
sudo status jenkins
```

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


