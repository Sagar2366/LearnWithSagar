## Build a Distributed Logging System (Part1)

### Steps to implement (with RabbitMQ):

- Create an EC2 instance with the following details:
  
  - **AMI:** Ubuntu
  - **Instance type:** t2.micro
  - **Volume:** 15GB
  - **Security group ports**: 22, 443, 15672
--- 

- Install RabbitMQ
```bash
sudo apt update && sudo apt install rabbitmq-server -y
```

- Enable management plugin
```bash
sudo rabbitmq-plugins enable rabbitmq_management
sudo systemctl restart rabbitmq-server
```
---

- Set Up a User and Queue
```bash
sudo rabbitmqctl add_user admin admin
sudo rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"
```
---

- Restart RabbitMQ
```bash
sudo systemctl restart rabbitmq-server
```
---

- Change created user to admin user
```bash
sudo rabbitmqctl set_user_tags admin administrator
sudo systemctl restart rabbitmq-server
```
---

- Access the RabbitMQ UI at `http://<public-ip>:15672`. Default credentials: `admin/admin`.
---

- Add logs queue to rabbitMQ
```bash
sudo apt install -y curl
curl -o rabbitmqadmin http://localhost:15672/cli/rabbitmqadmin
chmod +x rabbitmqadmin
sudo mv rabbitmqadmin /usr/local/bin/
```
---

- Create queue
```bash
rabbitmqadmin declare queue name=logs_queue
```
---

- Check created queues
```bash
rabbitmqadmin list queues
```
`Example output:`

![image](https://github.com/user-attachments/assets/487533b7-7c04-4a5e-a977-988a15193c42)
