# Daily DevOps + SRE Challenge Series – Season 2
## Day 11: The Text File Takedown – Wrangle Logs and Configs Like a Pro

### Introduction
Welcome to Day 11 of the Daily DevOps + SRE Challenge Series – Season 2! 🎉

Today, you’re diving into the art of text file mastery—crucial for taming logs, tweaking configs, and slicing through data in Linux. You’ll wield powerful tools to read, filter, sort, and edit text, turning raw files into actionable insights. By the end, you’ll:
- Navigate and extract data from text files with ninja-like precision.
- Transform and analyze logs/configs using command-line magic.
- Build SRE-ready skills for debugging and automation.

#### Why This Matters?
Text files are the lifeblood of Linux systems—logs in `/var/log`, configs in `/etc`, scripts everywhere. Mastering them is non-negotiable:
- **Universal Power**: `grep`, `awk`, and `sed` work across clouds, containers, and bare metal—your Swiss Army knife for any system.
- **Automation Edge**: `tail -f /var/log/app.log | grep ERROR` feeds live alerts into monitoring scripts.
- **SRE Superpower**: During outages, `sort | uniq -c` on logs spots patterns fast; `sed` fixes configs on the fly.
- **Interview Gold**: “How do you find errors in a 1GB log?” or “Extract IPs from a file?”—you’ll ace these.
- **Real-World Save**: An SRE at a cloud provider used `awk '{print $1}' /var/log/access.log | sort | uniq -c` to pinpoint a DDoS source, throttling it in minutes.

Grab your terminal—it’s time to take down the text chaos!


In UNIX and Linux systems, configuration and information management have traditionally relied on plain-text files. Despite the availability of graphical tools today, editing these files manually with a text editor remains essential, especially for full system control and on servers without GUIs. Aspiring system administrators must learn to use text editors and tools like find (to locate files) and grep (to search within files) to manage and configure Linux systems effectively.

 ## Practical Tasks Setup: Linux Text Avengers Training Camp

Welcome, recruits! You've been selected to join the Linux Text Avengers, the elite team responsible for manipulating text files to save the world (or at least your systems). Get ready for a series of challenges that will test your text-fu and prepare you for any text-based crisis.

### 1. Create Your Base of Operations

* Every hero needs a base! Create your training directory:

```bash
mkdir ~/textlab
cd ~/textlab
```


### 2. The Intelligence File

* Your first mission requires analyzing an intelligence file. Create `myfile.txt` with this vital information:

```bash
cat << EOF > myfile.txt
Line 1: This is a test file. Initializing systems...
Line 2: Administrator access granted. Beware of rogue agents.
Line 3: Memory usage: 500MB. System stable.
Line 4: Error log entry: Unauthorized access attempt detected.
Line 5: IP address: 192.168.1.100. Target server.
Line 6: Password: secret123. DO NOT SHARE.
Line 7: End of file. Mission critical.
EOF
```


### 3. Log Simulation: The Enemy's Activity

* Simulate enemy activity by creating fake logs. The logs directory will track their actions.

```bash
mkdir ~/textlab/logs
echo "error: disk full. System compromised!" > ~/textlab/logs/log1.log
echo "ERROR: network down. Communications disrupted!" > ~/textlab/logs/log2.log
echo "warning: low memory. System stability threatened!" >  ~/textlab/logs/log3.log
# Make log1.log larger than 1MB to simulate a real log.
for i in {1..10000}; do echo "filler line $i" >> ~/textlab/logs/log1.log; done
```


### 4. System Check

* Before you begin, ensure you have the necessary tools and access.
    * You should be able to read system files like `/etc/passwd` and `/var/log/messages` (some tasks might require sudo).
    * Install `mailx` for communication tasks:

```bash
sudo dnf install mailx # Or sudo apt install mailutils on Debian/Ubuntu
```


### Mission Briefing: Data Analysis

* Our world depends on your ability to analyze and manipulate text data. Every line in `myfile.txt` is critical:
    * Line 1: Initialization status.
    * Line 2: Administrator alert, with a hidden warning.
    * Line 3: Memory info to optimize system.
    * Line 4: Error log for security checks.
    * Line 5: Target IP address.
    * Line 6: A Secret!


## Operation: Text Manipulation

### Original Tasks: Core Skills Training

1. **Decoding the Intelligence:** Show line 5 from `~/textlab/myfile.txt` using two different methods. What does this IP address represent?
2. **Hunting the Target:** Locate text files in `~/textlab` containing `"192.168.1.100"`. Is a regex needed for this simple search?
3. **Reversing the Sabotage:** A rogue agent changed `"Administrator"` to `"root"` in `~/textlab/myfile.txt` using `sed`. Can you undo this sabotage *without* a backup?
4. **Memory Optimization:** Sort `myfile.txt` lines, simulating system performance by putting the largest memory value first (based on line 3). This tests ability to analyze numerical info within text.
5. **System Recon:** Extract the sixth column from `ps aux` to understand system usage. (This is a unchanged recon mission, unrelated to the rest of this scenario).
6. **Deleting Sensitive Info:** Remove the potentially compromised "Password" line (line 6) from `~/textlab/myfile.txt`.

### Additional Interesting Tasks: Advanced Missions

1. **Swapping Intel:** Swap lines 3 and 4 in `~/textlab/myfile.txt` using `vi/vim` to reorganize mission-critical info.
2. **Archiving Enemy Logs:** Find all `.log` files larger than 1MB under `~/textlab/logs`, and archive them to a `.tar.gz` in `~/textlab` for analysis. Think of this step as containing damage after an attack.
3. **Finding Patterns:** Use `grep`, `sort`, and `uniq` to count unique words with `"error"` (case-insensitive) in `~/textlab/logs/log1.log`. What does that data signify about system stability?
4. **Alerting the Team:** Search `~/textlab` for `"password"`, highlight it in color, and email this vital alert to yourself using `mail`. (Configure `mail` first if you haven't done so)


# Submission Guidelines
- Store your findings and execution steps in a markdown file (`solution.md`).
- Submit it in your GitHub repository and share the link.
- Post your experience on social media with **#getfitwithsagar #SRELife #DevOpsForAll**.
- Tag us in your posts for visibility and networking.

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
Sagar Utekar
