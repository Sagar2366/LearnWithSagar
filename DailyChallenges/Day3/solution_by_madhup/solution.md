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
sudo systemctl status jenkins
```

### Install and Configure Nginx as a Reverse Proxy
- Install Nginx on one EC2 instance (e.g., Grafana EC2):
  
```bash 
sudo apt-get install -y nginx
```
- Configure Nginx: Edit the Nginx configuration file:

```bash
sudo vim /etc/nginx/sites-available/default
```

Replace the file contents with:
```
server {
    listen 80;
    server_name <your-domain-name>;

    location / {
        proxy_pass http://127.0.0.1:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

server {
    listen 80;
    server_name <your-domian-name>;

    auth_basic "Restricted Access";
    auth_basic_user_file /etc/nginx/.htpasswd;

    location / {
        proxy_pass http://127.0.0.1:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

- Create a .htpasswd file for Grafana basic authentication:
```
sudo apt-get install -y apache2-utils
sudo htpasswd -c /etc/nginx/.htpasswd admin
```

- Test and restart Nginx:
```
sudo nginx -t
sudo systemctl restart nginx
```

- Generate a self-signed SSL certificate using certbot:
  - Install python-certbot
  ```bash
  sudo apt install certbot python3-certbot-nginx
  ```
  - Obtain an SSL Certificate
  ```bash
  sudo certbot --nginx -d <your-jenkins-domian> -d <your-grafana-domain>
  ```
