1. Create VPC MyAppVPC - IP range 192.168.0.0/16

2. Create Subnets
- Create a Public Subnet MyAppVPC - IP range 192.168.1.0/24 for this subnet. Enable Auto-assign public IPv4.
- Create a Private Subnet - IP range 192.168.1.32/27

3. Create an Internet Gateway - MyAppIGW and attach it to MyAppVPC.

4. Create a NAT Gateway & Allocate an Elastic IP Address to the Public Subnet.

Step 5: Update Route Tables
Route Table for Public Subnet:
```
Go to Route Tables > Select the public subnet's route table.
Add a route:
Destination: 0.0.0.0/0.
Target: Internet Gateway.
```

Route Table for Private Subnet:
```
Go to Route Tables > Select the private subnet's route table.
Add a route:
Destination: 0.0.0.0/0.
Target: NAT Gateway.
```

Step 6: Launch EC2 Instances
Database Instance (MySQL):
```
Launch an EC2 instance in the Private Subnet.
Choose an AMI with MySQL pre-installed or set up MySQL manually.
Use a Security Group to allow inbound traffic only from the Flask app's private IP.
```

Application Instance (Flask App):
```
Launch an EC2 instance in the Public Subnet.
Install Python, Flask, and required dependencies.
Ensure it can connect to the database via the private IP.
```

Step 7: Configure Flask and MySQL
</br>Set Up MySQL:
- SSH into the MySQL instance.
- Create a database and user for the Flask app:
```
CREATE DATABASE myapp;
CREATE USER 'flaskuser'@'192.168.1.%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON myapp.* TO 'flaskuser'@'192.168.1.%';
FLUSH PRIVILEGES;
```

</br>Set Up Flask:
- SSH into the Flask instance.
- Write the Flask app to connect to the MySQL database using its private IP:
```
import mysql.connector
from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
    try:
        conn = mysql.connector.connect(
            host="192.168.1.2",
            user="flaskuser",
            password="password",
            database="myapp"
        )
        return "Connected to the database!"
    except mysql.connector.Error as err:
        return f"Error connecting to database: {err}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
```

Step 8: Configure Security Groups
- For MySQL Instance:
Allow inbound traffic on port 3306 from the Flask instance's private IP range.
- For Flask Instance:
Allow inbound traffic on port 5000 from any public IP.

Step 9: Test Connectivity
- Ping and Telnet:
From the Flask instance, test connectivity to the MySQL private IP:
bash
```
ping 192.168.1.2
telnet 192.168.1.2 3306
```

- Test Flask App:
Access the Flask app using the public IP and ensure it connects to MySQL.

Step 10: Simulate and Troubleshoot Failures
- Stop MySQL Service:
SSH into the MySQL instance and run:
```
sudo systemctl stop mysql
```

- Troubleshoot:
Use ping and telnet to verify network connectivity.
Check Flask logs for error messages.
Verify the NAT gateway and route table configurations.
