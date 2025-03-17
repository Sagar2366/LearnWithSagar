## Creating a custom AMI, apply security hardening, and deploy it across AWS regions.

### Steps to implement (Custom AMI):

- Login to your AWS account and create an EC2 instance with the following details:
  
  - **AMI:** Ubuntu
  - **Instance type:** t2.micro
  - **Volume:** 10GB
---
- Install apache web server, so that we can verify after creating custom AMI:
```bash
sudo apt update
sudo apt install apache2 -y
```
> Note: Page will be accessed on http:\<public-ip\>:80
---
- Apply security hardening (CIS Benchmarks).
  - Open /etc/ssh/sshd_config file and uncomment the below line ```PermitRootLogin prohibit-password``` to ```PermitRootLogin no```:
    
  ![image](https://github.com/user-attachments/assets/5a6b7046-295c-440c-860d-04fcc851f196)

  - Restart ssh
  ```bash
  sudo systemctl restart ssh
  ``` 
---
- Go to EC2 dashboard, select the instance where you deployed apache web server and then click on **Actions** and **Image and Templates** then **Create image**
---
- After creating the custom image, wait for the Custom AMI to be in **available** state.
![image](https://github.com/user-attachments/assets/9b982b25-9503-4d28-9243-b7a803f414a0)
---
- Once the status of custom AMI is available then select the custom AMI and click on **Actions** and click on **Copy AMI**
  
  - Enter all the required details and make sure to select **Destination Region** (For example: I am using N.Virginia and I selected N.california as a Destination Region).
  ![image](https://github.com/user-attachments/assets/db4c88f1-af2c-4bd0-8c01-d9170bad7a04)
---
- Now, move to N.california region and go to EC2-->AMI's and check for AMI status to be in **available**:
---
- Once, your AMI status is available then create an EC2 instance from that AMI
---
- Copy Publich IP of the EC2 instance created from custom AMI and paste it on browser, you should see apache web page.
---
  
### Steps to implement (Volumes and snapshots)
- Login to N.Virginia EC2 instance and create one file or directory under root directory **/**
```bash
cd /
sudo mkdir /testdir
```
---
- Now, go to volumes and select the volume attached your instance and go to **Actions**, click on **Create Snapshot**
---
- Once, snapshot is created, select the created snapshot and go to **Actions**, click on **Copy Snapshot**.
---
- After snapshot is copied to another region, create a new volume from the snapshot.
---
- Create new instance with volume created from copied snapshot and ssh into the new instance
---
- Now mount it with the directory
```bash
sudo mkdir /newdisk
sudo mount /dev//<your-partition-name/> /newdisk
```
---
- Check the directory is a mountpoint
```bash
mountpoint /newdisk
```
---
- Check if your created directory **testdir** is available.
