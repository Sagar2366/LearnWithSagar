# Daily DevOps + SRE Challenge Series – Season 2  
## Day 8: Kickstart Your Journey with Linux & Virtualization  

## Introduction  
Welcome to Day 8 of the Daily DevOps SRE Challenge Series - Season 2! 🎉  

Today, we’re starting strong with **Linux and Virtualization**—the bedrock of DevOps and SRE workflows. By the end of this challenge, you will:  
- Understand what Unix and Linux are and why they matter.  
- Explore **virtualization** and its role in modern infrastructure.  
- Compare popular **Linux distributions** and their use cases.  
- Set up **AWS EC2 instances** with different Linux distros and install **RHEL** on VirtualBox locally.  

---

### **Why This Matters?**  
Linux powers the cloud, containers, and automation tools that DevOps and SRE engineers rely on daily. Virtualization is the foundation of scalable infrastructure—think AWS, testing environments, and cost savings. Together, they’re your launchpad to mastering modern IT, unlocking roles like Cloud Engineer, SRE, and System Admin!

---

## 1️⃣ What Are Unix and Linux?  

- **Unix:** A powerful, multi-user, multitasking OS born in the 1970s at AT&T Bell Labs. It’s the ancestor of many modern systems, built for stability and modularity.  
- **Linux:** A Unix-inspired, open-source OS—free, customizable, and community-driven. It runs everywhere: servers, clouds, even your phone!  

**Key Difference:** Unix is often proprietary (e.g., Solaris), while Linux is open-source and adaptable (e.g., Ubuntu, RHEL).  

**Fun Fact:** The `ls` command in Linux? It’s a Unix legacy, reborn for today’s systems!

---

## 2️⃣ Virtualization Basics  

**What is Virtualization?**  
Virtualization lets you run multiple **virtual machines (VMs)** on one physical host, splitting resources like CPU, RAM, and storage. It’s like having a dozen computers in one box!  

**How It Works:**  
A **hypervisor** manages VMs, abstracting hardware to create isolated environments.  

**Types of Hypervisors:**  
| Type    | Description         | Examples            |
|---------|---------------------|---------------------|
| Type 1  | Runs on bare metal  | VMware ESXi, Hyper-V |
| Type 2  | Runs on a host OS   | VirtualBox, VMware Workstation |

**Benefits:**  
- **Cost Savings:** One server hosts multiple VMs.  
- **Flexibility:** Snapshot and restore VMs for backups.  
- **Dev/Test/QA:** Spin up isolated environments fast.  
- **Cloud Power:** AWS, GCP, and Azure rely on virtualization.  

**Quick Quiz:** Which hypervisor type is better for production servers? *(Hint: Think bare metal!)*  

---

## 3️⃣ Types of Linux Distributions  

Linux comes in flavors called **distributions**, each tailored to specific needs. Here’s a rundown:  

| Distribution | Description                  | Use Cases           | Advantages             | Disadvantages          |
|--------------|------------------------------|---------------------|------------------------|------------------------|
| Ubuntu       | User-friendly Linux distro   | Beginners, Developers | Easy to use, LTS support | Slightly bloated for servers |
| Debian       | Stable, free software-focused| Servers, Advanced Users | Rock-solid, vast repos | Slower release cycle   |
| Fedora       | Cutting-edge tech showcase   | Developers          | Latest features, modular | Frequent updates      |
| CentOS       | Enterprise-grade stability   | Servers             | RHEL-like, free, SELinux | End-of-life for CentOS 7 |
| Kali Linux   | Security and pentesting toolkit | Security Pros    | 600+ tools preloaded   | Not for general use    |
| RHEL         | Supported enterprise solution | Enterprises        | Secure, scalable, support | Subscription cost    |

### **When to Use What?**  
| Scenario            | Ubuntu | RHEL | Kali |
|---------------------|--------|------|------|
| Learning Linux      | ✅     | ❌   | ❌   |
| Enterprise production | ❌   | ✅   | ❌   |
| Ethical hacking     | ❌     | ❌   | ✅   |

**Pro Tip:** Match your distro to your goal—Ubuntu for learning, RHEL for enterprise skills!

---

## 4️⃣ Why Learn Linux?  
Linux is *the* skill for DevOps, SRE, and Cloud Engineering. Here’s why it’s non-negotiable for DevOps and SRE engineers:  

### Why Linux Matters for DevOps Engineers  
- **Automation Foundation:** DevOps is all about automating workflows—Linux’s command-line tools (e.g., `bash`, `awk`, `sed`) and scripting capabilities make it ideal for building CI/CD pipelines (Jenkins, GitLab CI).  
- **Containerization:** Docker and Kubernetes run on Linux kernels. Understanding Linux (e.g., namespaces, cgroups) is key to managing containers at scale.  
- **Cloud Dominance:** Most cloud providers (AWS, GCP, Azure) use Linux VMs. Deploying apps or infrastructure-as-code (Terraform, Ansible) requires Linux fluency.  
- **Efficiency:** Linux’s lightweight nature and customization let DevOps engineers optimize systems for performance and cost—critical for microservices and serverless architectures.  

### Why Linux Matters for SRE Engineers  
- **Reliability at Scale:** SREs ensure systems are up 99.99% of the time. Linux’s stability (e.g., Debian, RHEL) and tools like `systemd` and `SELinux` help enforce uptime and security SLAs.  
- **Monitoring & Debugging:** Tools like Prometheus, Grafana, and `strace` run natively on Linux, letting SREs trace issues (e.g., memory leaks, network latency) in production.  
- **Incident Response:** When systems fail, SREs use Linux commands (`top`, `netstat`, `journalctl`) to diagnose and fix problems fast—often under pressure.  
- **Infrastructure Mastery:** SREs manage fleets of servers or clusters (e.g., Kubernetes). Linux’s kernel-level control is essential for tuning performance and handling failures gracefully.  

### Broader Impact  
- **Cloud:** AWS, Azure, and GCP run on Linux VMs.  
- **Containers:** Kubernetes and Docker are Linux-native.  
- **Automation:** CI/CD tools thrive on Linux.  
- **Monitoring:** Prometheus and Grafana are Linux-friendly.  

### Roles It Unlocks:  
- Site Reliability Engineer (SRE)  
- Cloud/DevOps Engineer  
- System Administrator  

**Challenge Question:** Can you name a DevOps tool that relies on Linux? *(Hint: Think containers!)*  

---

## 5️⃣ Challenge Breakdown  

### **📝 Theoretical Questions**  
Answer these to solidify your understanding:  
1. What is Unix, and how does it relate to Linux?  
2. How does Linux’s open-source nature benefit DevOps workflows?  
3. What’s the role of the Linux kernel in virtualization?  
4. What’s the difference between Type 1 and Type 2 hypervisors?  
5. Why might an SRE prefer Linux for monitoring production systems?  

---

### **⚙️ Practical Challenge: Mastering Linux & Virtualization**  

#### **Step 1: Launch EC2 Instances with Linux Distros**  
**Goal:** Deploy three Linux distros on AWS EC2 to explore their differences.  
1. Log into AWS → EC2 → "Launch Instance."  
2. Deploy these AMIs (use `t2.micro` for free tier):  
   - **Ubuntu 22.04 LTS**: Search "Ubuntu 22.04" in AMI catalog.  
   - **Amazon Linux 2**: Default EC2 option.  
   - **RHEL 9**: Search "Red Hat Enterprise Linux 9."  
3. Set up a key pair (e.g., `mykey.pem`).  
4. Configure security group: Allow port 22 (SSH) from your IP.  
5. SSH into each:  
   ```bash
   ssh -i mykey.pem ubuntu@<public-ip>      # Ubuntu
   ssh -i mykey.pem ec2-user@<public-ip>    # Amazon Linux
   ssh -i mykey.pem ec2-user@<public-ip>    # RHEL

6. Run this on each:  
   ```bash
   cat /etc/os-release


**Troubleshooting Tip:** SSH failing? Double-check your security group and key permissions (`chmod 400 mykey.pem`).

---

### **Step 2: Install RHEL on VirtualBox Locally**  
**Goal:** Set up a local RHEL VM to grasp virtualization hands-on.  

**Downloads:**  
- VirtualBox: [virtualbox.org](https://www.virtualbox.org)  
- RHEL ISO: [redhat.com](https://developers.redhat.com/products/rhel/download) (free developer account).  

1. Open VirtualBox → "New" → Name: "RHEL9" → Type: Linux → Version: Red Hat (64-bit).  
2. Allocate:  
   - RAM: 2 GB+  
   - Disk: 20 GB+ (dynamic)  
3. Mount the RHEL ISO in Settings → Storage.  
4. Start the VM and follow the installer (default settings are fine).  
5. Post-install, log in and run:  
   ```bash
   sudo dnf update -y
   cat /etc/os-release


**Pro Tip:** VM won’t boot? Enable VT-x/AMD-V in your BIOS settings.

---

## 6️⃣ Submission Guidelines  
✅ **Proof of Completion:**  
- Screenshot of AWS EC2 dashboard with all three instances running.  
- Screenshot of RHEL VM terminal after login.  
- Output of `cat /etc/os-release` from each system (EC2 + VM).  

✅ **Documentation:**  
- Steps you took to launch EC2 instances and set up the VM.  
- Any challenges faced (e.g., SSH issues, VM crashes) and how you solved them.  

**Example Submission:**  
- Ubuntu output: `NAME="Ubuntu" VERSION="22.04.1 LTS (Jammy Jellyfish)"`  
- Screenshot showing all instances in "Running" state.

---

## 7️⃣ Bonus Tasks 🎯  
- **Explore:** Install `htop` on your Ubuntu EC2 (`sudo apt install htop -y`) and screenshot the process list.  
- **Compare:** Run `uname -r` on all systems to compare kernel versions. What differences do you spot?  

### **Share Your Progress!**  
Post your experience on social media with the hashtags: **#getfitwithsagar, #SRELife, #DevOpsForAll**  

---

## **Join Our Community**  
Connect with fellow learners:  
- **Discord:** [Join here](https://discord.gg/mNDm39qB8t)  
- **Google Group:** [Join here](https://groups.google.com/forum/#!forum/daily-devops-sre-challenge-series/join)  
- **YouTube:** [Subscribe here](https://www.youtube.com/@Sagar.Utekar)  

---

Keep learning and happy exploring!
