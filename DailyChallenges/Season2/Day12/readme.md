# Daily DevOps + SRE Challenge Series – Season 2
## Day 12: The Process Power-Up – Command Your Linux System Like a Pro

### Introduction
Welcome to **Day 12** of the Daily DevOps + SRE Challenge Series – Season 2! 🎉

Today, you’re stepping into the control room of your Linux system, mastering the art of **process management**. Processes are the heartbeat of any system—every command, script, or service runs as a process. Knowing how to monitor, prioritize, and control them is like wielding a superpower for debugging, optimizing, and keeping systems humming. By the end of this challenge, you’ll:
- Monitor running processes with precision using tools like `ps` and `top`.
- Control process priorities to optimize system performance.
- Manage background jobs and terminate rogue processes like a seasoned SRE.

#### Why This Matters?
Process management is critical for DevOps and SRE roles:
- **System Health**: Spot CPU-hogging processes before they crash your app.
- **Automation**: Script `kill` or `nice` commands to automate resource management.
- **Outage Recovery**: During incidents, `top` and `pkill` help you isolate and stop problematic services.
- **Interview Win**: Questions like “How do you find a zombie process?” or “What’s the difference between `SIGTERM` and `SIGKILL`?” are common.
- **Real-World Impact**: An SRE at a fintech firm used `htop` to trace a memory leak in a trading app, saving millions by preventing downtime.

Grab your terminal and let’s power up your process-fu!

---

### 1. Understanding Processes
- **Definition**: A process is an instance of a running program, identified by a unique **Process ID (PID)**. Every command (e.g., `ls`), script, or service (e.g., `httpd`) creates a process.
- **Attributes**:
  - **PID**: Unique identifier (e.g., 1234).
  - **PPID**: Parent Process ID, linking to the process that started it (e.g., `bash` spawns `ls`).
  - **User**: The account running the process (e.g., `root` or `user1`).
  - **State**: Current status:
    - **R** (Running): Actively using CPU.
    - **S** (Sleeping): Waiting for an event (e.g., I/O).
    - **D** (Uninterruptible Sleep): Waiting for I/O, can’t be killed easily.
    - **Z** (Zombie): Defunct, awaiting parent cleanup.
    - **T** (Stopped): Paused, often via `Ctrl+Z`.
- **Types**:
  - **Foreground**: Occupies the terminal (e.g., `vim`).
  - **Background**: Runs without terminal control (e.g., `sleep 100 &`).
  - **Daemons**: System services running continuously (e.g., `sshd`).
- **Process Creation**: Processes are forked (copied) from a parent, often `init` (PID 1) or `systemd` in RHEL.

### 2. Monitoring Processes
To manage processes, you first need to see what’s running. RHEL provides several tools for this purpose.

- **`ps` (Process Status)**:
  - Displays a snapshot of processes.
  - **Key Options**:
  - `-a`: Show all processes with a terminal (excludes daemons).
  - `-u user`: Filter by user (e.g., `ps -u root`).
  - `-x`: Include processes without a terminal (e.g., daemons).
  - `aux`: BSD-style, shows all processes (user, PID, %CPU, %MEM, command).
  - `-e`: Show every process (System V style).
  - `-f`: Full format (includes PPID, start time).
  - `-ef`: Combines `-e` and `-f` for hierarchy view.
  - `-p PID`: Select specific PID (e.g., `ps -p 1234`).
  - `-C command`: Select by command name (e.g., `ps -C httpd`).
  - `--sort=field`: Sort output (e.g., `ps aux --sort=-%cpu` for highest CPU first).
  - `-o field1,field2`: Customize columns (e.g., `ps -o pid,comm,state`).
  - `-l`: Long format (includes nice value, priority).
  - Common options:
    - `ps aux`: Shows all processes in BSD format (user, PID, %CPU, %MEM, command).
    - `ps -ef`: Displays all processes in System V format, including PPID.
    - `ps -u username`: Lists processes for a specific user.
    - `ps -p 1234`: Shows details for PID 1234.
  - Example:
    ```bash
    ps aux | grep httpd
    ```
    Lists all `httpd` processes with resource usage.
  - **Customization**: Use `ps -o pid,ppid,comm,state` to select specific columns (PID, PPID, command, state).

- **`top`**:
  - Real-time, interactive process viewer.
  - Key features:
    - Displays CPU, memory, and load averages.
    - Sort by CPU (`P`), memory (`M`), or PID (`N`).
    - Kill processes: Press `k`, enter PID, select signal (e.g., 15 for `SIGTERM`).
    - Adjust priority: Press `r`, enter PID, set nice value.
  - Example:
    ```bash
    top
    ```
    Press `q` to quit.
  - **Fields**:
    - `%CPU`: CPU usage percentage.
    - `%MEM`: Memory usage percentage.
    - `NI`: Nice value (priority).
    - `S`: Process state (R, S, Z, etc.).
  
- **`uptime`**:
  - Shows system load averages (1, 5, 15 minutes).
  - Example:
    ```bash
    uptime
    ```
    Output: `12:34:56 up 2 days, 3:45, 2 users, load average: 0.50, 0.75, 1.00`.
  - **Interpretation**: A load average above the number of CPU cores indicates resource contention.

### 3. Controlling Processes with Signals
Processes communicate via **signals**, which instruct them to perform actions like stopping or restarting.

- **Common Signals**:
  - `SIGTERM` (15): Requests graceful termination (default for `kill`).
  - `SIGKILL` (9): Forces immediate termination (use cautiously, as it doesn’t allow cleanup).
  - `SIGHUP` (1): Reloads configuration for daemons (e.g., `kill -1 1234`).
  - `SIGSTOP` (19): Pauses a process (resumed with `SIGCONT`).
  - `SIGCONT` (18): Resumes a paused process.
- **Commands**:
  - **`kill`**: Sends a signal to a PID.
    ```bash
    kill -15 1234  # Graceful stop
    kill -9 1234   # Force kill
    ```
  - **`killall`**: Sends a signal to all processes matching a name.
    ```bash
    killall -15 httpd  # Stops all httpd processes
    ```
  - **`pkill`**: Similar to `killall`, but supports patterns.
    ```bash
    pkill -u user1  # Terminates all processes for user1
    ```

### 4. Managing Process Priorities
CPU resources are allocated based on process priority, controlled by **nice** values (-20 highest, +19 lowest).

- **`nice`**:
  - Sets priority when starting a process.
  - Example:
    ```bash
    nice -n 10 sleep 1000  # Runs with low priority
    ```
  - Range: `-20` (high priority) to `+19` (low priority, default 0).

- **`renice`**:
  - Adjusts priority of a running process.
  - Example:
    ```bash
    renice 5 -p 1234  # Sets nice value to 5 for PID 1234
    ```
  - Requires `root` for increasing priority (lowering nice value below 0).

- **Verification**:
  - Check nice value with `ps -l` (column `NI`) or `top` (press `f`, select `NI`).
  - Example:
    ```bash
    ps -lp 1234
    ```

### 5. Job Control
Job control manages foreground and background processes within a terminal session.

- **Foreground Processes**:
  - Run interactively, locking the terminal (e.g., `vim`).
- **Background Processes**:
  - Run without terminal control, freeing it for other tasks.
  - Start with `&`:
    ```bash
    sleep 1000 &
    ```
- **Key Commands**:
  - **`jobs`**: Lists background/stopped jobs.
    ```bash
    jobs
    ```
    Output: `[1]+ Running sleep 1000 &`.
  - **`fg`**: Brings a job to the foreground.
    ```bash
    fg %1  # Brings job 1 to  foreground
    ```
  - **`bg`**: Resumes a stopped job in the background.
    ```bash
    bg %1
    ```
  - **Suspend**: Press `Ctrl+Z` to pause a foreground process.
  - **Terminate**: Use `Ctrl+C` to stop a foreground process.

- **Example Workflow**:
  ```bash
  sleep 1000    # Runs in foreground
  Ctrl+Z        # Suspends
  jobs          # Shows [1]+ Stopped
  bg %1         # Resumes in background
  fg %1         # Brings back to foreground
  Ctrl+C        # Terminates
  ```

### 6. Advanced Monitoring Tools
For deeper insights, RHEL offers additional tools.

- **`pidstat`** (part of `sysstat` package):
  - Monitors CPU, memory, or I/O per process.
  - Example:
    ```bash
    pidstat -u 1 5  # CPU usage every second for 5 iterations
    ```
- **`lsof`**:
  - Lists open files associated with a process.
  - Example:
    ```bash
    lsof -p 1234  # Files opened by PID 1234
    ```
- **`free`**:
  - Shows system memory usage, useful alongside `top` for memory-intensive processes.
    ```bash
    free -h
    ```

### 7. Process Troubleshooting
- **High CPU Usage**:
  - Use `top` or `ps aux --sort=-%cpu` to identify culprits.
  - Lower priority with `renice` or terminate with `kill`.
- **Zombies**:
  - Find with `ps aux | grep Z`.
  - Kill parent process to clean up (e.g., `kill -9 <PPID>`).
- **Out-of-Memory Issues**:
  - Check `free -h` and `top` (%MEM column).
  - Terminate non-critical processes or adjust `nice` values.

### 8. Systemd and Processes
- Processes like `httpd` or `sshd` are managed by `systemd` units.
- Check service processes:
  ```bash
  systemctl status httpd
  ```
  Shows main PID and recent logs.
- Stop a service to kill its processes:
  ```bash
  systemctl stop httpd
  ```

## Practical Tasks: Operation Server Rescue: Diagnose, Stabilize, and Optimize
As an SRE on call, your task is to diagnose, stabilize, and optimize a production server under heavy load from rogue processes. This guide assumes a Fedora or RHEL system.

### Setup the Crisis

1. **Create a Workspace**:

```bash
mkdir ~/processlab
cd ~/processlab
```

2. **Simulate Server Stress**:
    - **CPU-intensive script**:

```bash
echo 'while true; do :; done' &gt; cpu_hog.sh
chmod +x cpu_hog.sh
```

    - **Memory-heavy script**:

```bash
echo 'python3 -c "while True: a = [0] * 1000000"' &gt; mem_hog.sh
chmod +x mem_hog.sh
```

    - **Sleep script**:

```bash
echo 'sleep 3600' &gt; sleeper.sh
chmod +x sleeper.sh
```

3. **Install Tools (if needed)**:

```bash
sudo dnf install python3 procps-ng sysstat
```


### Task: Stabilize the Server

#### Assess the Load

1. **Check Load Averages**:
Run `uptime` to check load averages and save output to `~/processlab/load.txt`.

```bash
uptime &gt; ~/processlab/load.txt
```

2. **Note CPU Cores**:
Use `lscpu` to note the number of CPU cores and save to `~/processlab/cpu_info.txt`.

```bash
lscpu &gt; ~/processlab/cpu_info.txt
```

3. **Compare Load to Cores**:
High load (>2 on 2 cores) confirms stress.

#### Survey Running Processes

1. **List All Processes**:
List all processes with `ps aux`, pipe to `less` for paging, and save to `~/processlab/all_processes.txt`.

```bash
ps aux &gt; ~/processlab/all_processes.txt
```

2. **List Processes Sorted by User**:
Append the list of processes sorted by user to `~/processlab/all_processes.txt`.

```bash
ps aux --sort=user &gt;&gt; ~/processlab/all_processes.txt
```

3. **Show Custom Columns**:
Show custom columns (PID, user, group, VSZ, RSS, command) with `ps -e -o pid,user,group,vsz,rss,comm` and save to `~/processlab/custom_processes.txt`.

```bash
ps -e -o pid,user,group,vsz,rss,comm &gt; ~/processlab/custom_processes.txt
```


#### Launch Rogue Processes

1. **Start Background Jobs**:

```bash
./cpu_hog.sh &amp;
./mem_hog.sh &amp;
./sleeper.sh &amp;
```

2. **Start a Foreground Job**:

```bash
./cpu_hog.sh
```

Suspend it with `Ctrl+Z`.

#### Manage Jobs

1. **List Jobs**:
Run `jobs` to list all jobs (expect 3 running, 1 stopped).
2. **Resume Stopped Job**:
Resume the stopped `cpu_hog.sh` job in the background with `bg`.
3. **Bring Job to Foreground and Terminate**:
Bring the first `sleeper.sh` job to the foreground with `fg %1`, then terminate it with `Ctrl+C`.
4. **Confirm Job Removal**:
Check `jobs` to confirm `sleeper.sh` is gone.

#### Monitor in Real-Time

1. **Run Top**:
Run `top`, sort by CPU (P), then memory (M).
2. **Identify mem_hog.sh PID**:
Identify the `mem_hog.sh` PID (high `%MEM`).
3. **Terminate mem_hog.sh**:
In `top`, press `k`, enter the `mem_hog.sh` PID, and send `SIGTERM` (15) to stop it gracefully.
4. **Quit Top**:
Quit `top` with `q`.

#### Adjust Priorities

1. **Find PID of cpu_hog.sh**:
Find the PID of one `cpu_hog.sh` with `ps aux | grep cpu_hog`.
2. **Set Nice Value to +5**:

```bash
renice 5 -p &lt;PID&gt;
```

3. **Increase Priority to -5**:

```bash
sudo renice -5 -p &lt;PID&gt;
```

4. **Verify Priority Change**:
Verify with `ps -lp &lt;PID&gt;` (check NI column). Save output to `~/processlab/priority.txt`.

```bash
ps -lp &lt;PID&gt; &gt; ~/processlab/priority.txt
```


#### Trace Process Hierarchy

1. **Show Process Hierarchy**:
Run `ps fax | grep -B5 cpu_hog` to show `cpu_hog.sh` processes and their parent shell.
2. **Save Hierarchy**:
Save output to `~/processlab/hierarchy.txt`.

```bash
ps fax | grep -B5 cpu_hog &gt; ~/processlab/hierarchy.txt
```


#### Clean Up Stragglers

1. **Start Another Rogue Process**:
From a second terminal, start another rogue process:

```bash
./cpu_hog.sh &amp;
exit
```

2. **Confirm Process Running**:
Back in the first terminal, use `ps aux | grep cpu_hog` to confirm it’s still running.
3. **Terminate All cpu_hog.sh Processes**:

```bash
killall -15 cpu_hog.sh
```

4. **Verify Termination**:
Verify with `ps aux | grep cpu_hog` (no results).

#### Final Sweep

1. **Check Load Again**:
Check load again with `uptime`. Append to `~/processlab/load.txt`.

```bash
uptime &gt;&gt; ~/processlab/load.txt
```

2. **Force-Stop Remaining Processes**:
If load is still high, use `killall -9 sleeper.sh` to force-stop any remaining processes.
3. **Save Final Processes**:
Save final `ps aux` output to `~/processlab/final_processes.txt`.

```bash
ps aux &gt; ~/processlab/final_processes.txt
```


#### Document Findings

In `~/processlab/notes.txt`, document:

- Which process caused the most stress (`cpu_hog.sh` or `mem_hog.sh`).
- How load changed after cleanup.
- One lesson learned (e.g., “`SIGTERM` is safer than `SIGKILL`”).


## **Submission Guidelines** 
- Store your findings and execution steps in a markdown file (`solution.md`).
- Submit it in your GitHub repository and share the link.
- Post your experience on social media with **#getfitwithsagar #SRELife #DevOpsForAll**.
- Tag us in your posts for visibility and networking.

---

## **Join Our Community** 

To make the most of this journey, connect with fellow learners:
- **Discord** – Ask questions and collaborate: [Join here](https://discord.gg/mNDm39qB8t)
- **Google Group** – Get updates and discussions: [Join here](https://groups.google.com/forum/#!forum/daily-devops-sre-challenge-series/join)
- **YouTube** – Watch solution videos and tutorials: [Subscribe here](https://www.youtube.com/@Sagar.Utekar)

---

---

## **Stay Motivated!** 

Every challenge you complete brings you closer to mastering Git, DevOps, and SRE practices. Keep pushing your limits and collaborating with the community.

Happy Learning! 

**Best regards,**  
Sagar Utekar
