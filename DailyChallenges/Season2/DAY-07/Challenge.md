# Day 07: GitHub Self-Hosted Runners

## Introduction
Welcome to Day 07 of the DevOps SRE Daily Challenge! 🎉

Today, we focus on **GitHub Self-Hosted Runners**, a powerful way to customize GitHub Actions workflows by running jobs on your own infrastructure.

By the end of this challenge, you will:
- Understand what GitHub runners are and their types.
- Compare **hosted** vs. **self-hosted** runners with advantages and disadvantages.
- Set up a **self-hosted runner** on an **AWS EC2 instance**.
- **Dockerize and deploy** the Snake game from [this repo](https://github.com/clear-code-projects/Snake) using the self-hosted runner.

---

## 1️⃣ What Are Runners?

GitHub **runners** are machines that execute workflows defined in **GitHub Actions**. These runners can be:
- Hosted by **GitHub** (default).
- **Self-hosted** (your own machine or cloud instance).


## 2️⃣ Types of GitHub Runners

| Runner Type      | Description | Use Cases | Advantages | Disadvantages |
|-----------------|-------------|-----------|-------------|---------------|
| **GitHub-Hosted** | Managed by GitHub with predefined environments. | General CI/CD workflows with minimal setup. | No maintenance, built-in scaling. | Limited customization, restricted software access. |
| **Self-Hosted** | User-managed runner on a personal machine or cloud instance. | Workflows needing custom dependencies or private network access. | Full control, cost-effective for large workloads. | Requires maintenance, security responsibility. |

### When to Use What?

| Scenario | Use **GitHub-Hosted** | Use **Self-Hosted** |
|----------|---------------------|---------------------|
| Simple CI/CD workflows | ✅ | ❌ |
| Need custom software/dependencies | ❌ | ✅ |
| Need access to private networks | ❌ | ✅ |
| Cost-effective for large workloads | ❌ | ✅ |
| Security and compliance control | ❌ | ✅ |

---

## 3️⃣ Challenge Breakdown

### **📝 Theoretical Questions**
Answer the following questions:
1. What is a GitHub runner?
2. How do self-hosted runners differ from GitHub-hosted runners?
3. What security considerations should you take when using self-hosted runners?
4. How can you scale self-hosted runners?
5. Can a single self-hosted runner be used for multiple repositories? Why or why not?

---

### **⚙️ Practical Challenge: Setting Up a Self-Hosted Runner**

#### **Step 1: Create an EC2 Instance**
1. Launch an AWS EC2 instance (Ubuntu 22.04 recommended).
2. Allow inbound traffic on ports **22 (SSH)** and **80 (HTTP)**.

#### **Step 2: Configure GitHub Self-Hosted Runner**
1. Navigate to your **GitHub repository** → **Settings** → **Actions** → **Runners**.
2. Click **"New self-hosted runner"**, select **Linux**, and follow the instructions to set it up.
3. SSH into the EC2 instance and install the runner using the provided commands.
4. Start the runner:
   ```bash
   ./run.sh
   ```

#### **Step 3: Deploy the Snake Game**
1. Install **Docker** on your EC2 instance:
   ```bash
   sudo apt update
   sudo apt install docker.io -y
   ```
2. Clone the **Snake Game repository**:
   ```bash
   git clone https://github.com/clear-code-projects/Snake
   cd Snake
   ```
3. Build and run the application as a Docker container:
   ```bash
   docker build -t snake-game .
   docker run -d -p 80:5000 snake-game
   ```
4. Confirm the deployment by accessing `http://<EC2-Public-IP>` in a browser.

#### **Step 4: Take Screenshots for Submission**
- Running EC2 instance (`aws ec2 describe-instances`).
- GitHub Actions workflow logs showing execution on the self-hosted runner.
- Webpage running the Snake Game.

---

## 4️⃣ Submission Guidelines

✅ **Proof of Completion:**
- Screenshot of **EC2 instance running**.
- Screenshot of **GitHub Actions logs showing execution on self-hosted runner**.
- Screenshot of **Snake Game running in the browser**.

✅ **Documentation:**
- Steps taken to configure the self-hosted runner.
- Learnings and challenges faced.

---

## 5️⃣ Bonus Tasks 🎯
- Use **GitHub Actions** to automate the deployment.
- Auto-scale self-hosted runners with **multiple EC2 instances**.
- Implement **load balancing** using **Nginx**.

### **Share Your Progress!**
Post your experience on social media with the hashtags: **#getfitwithsagar, #SRELife, #DevOpsForAll**

---

### **Why This Matters?**
Understanding **self-hosted GitHub runners** is critical for enterprises managing private infrastructure, optimizing costs, and ensuring workflow security.

Keep learning and happy automating! 🚀

Kind Regards,  
Sagar Utekar and Raihan
