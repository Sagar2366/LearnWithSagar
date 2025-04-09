# Daily DevOps + SRE Challenge Series – Season 2
## Day 10: Navigating and Managing the Linux Filesystem

### Introduction
Welcome to Day 10 of the Daily DevOps + SRE Challenge Series - Season 2! 🎉

Today, we’re exploring the Linux filesystem—its structure, navigation, and essential file management tools. You’ll master commands to move around, create, copy, move, and delete files, all while building skills critical for DevOps and SRE workflows. By the end, you’ll:
- Understand the filesystem hierarchy and path navigation.
- Gain fluency in tools like `cd`, `mkdir`, `cp`, `mv`, and `rm`.
- Apply these on your Day 1 EC2 instances or RHEL VM.

#### Why This Matters?
The filesystem is the foundation of Linux operations. Whether you’re deploying apps, troubleshooting outages, or prepping for RHCSA, these skills are non-negotiable. Here’s why:
- **Universal Skill**: Every Linux system—from cloud instances to Kubernetes pods—relies on the filesystem. Commands like `cd /var/log` or `rm -rf /tmp/cache` work everywhere.
- **Automation Backbone**: Scripts like `mv *.log /archive/$(date +%Y%m%d)` organize logs daily in cron jobs or CI/CD pipelines.
- **SRE Efficiency**: During incidents, `cp -r /etc/nginx /backup` or `find / -name core.*` pinpoints crash dumps fast, saving downtime.
- **RHCSA Must-Know**: The exam tests navigation (`/etc` vs `../`), file ops (`touch`, `mkdir -p`), and cleanup (`rm -rf`).
- **Career Boost**: Fluency in filesystem tasks impresses in interviews—think “How do you restore a config?” or “How do you free disk space?”
- **Real-World Example**: An SRE at a fintech firm used `mkdir -p /data/backups/$(date +%F) && cp -r /prod/data/* /data/backups/$(date +%F)` to snapshot critical data before a risky upgrade, averting disaster when it failed.

Let’s dive in and take control of the filesystem!

---


### Linux Filesystem Overview

The Linux filesystem is a hierarchical structure used to store all information on a computer. It is based on the UNIX system, where nearly everything, including data, commands, symbolic links, devices, and directories, is represented within the filesystem.

### Structure and Navigation
<img width="707" alt="Screenshot 2025-04-09 at 5 57 43 AM" src="https://github.com/user-attachments/assets/f9d3fd0e-284f-4ebe-8328-0bb5aa51b254" />

1. **Hierarchy**: The filesystem is organized like an upside-down tree with the root directory (`/`) at the top. Below the root are common directories such as `/bin`, `/dev`, `/home`, `/lib`, and `/tmp`. These directories can contain subdirectories, creating a hierarchical structure.
2. **Paths**:
    * **Full Path**: Specifies the complete route from the root directory to a file or directory (e.g., `/home/joe/Documents/memos/memo1.doc`).
    * **Relative Path**: Specifies the path relative to the current directory (e.g., `memo1.doc` if the current directory is `/home/joe/Documents/memos`).

### Common Linux Directories

#### Key Directories

- **`/bin`**: Contains common Linux user commands like `ls`, `sort`, `date`, and `chmod`.
- **`/boot`**: Contains the bootable Linux kernel and boot loader configuration files (GRUB).
- **`/dev`**: Contains files representing access points to devices (e.g., `tty*`, `fd*`, `hd*`, `sd*`, `ram*`, `cd*`).
- **`/etc`**: Contains administrative configuration files, which are typically plaintext files that can be edited with a text editor.
- **`/home`**: Contains directories for each regular user account (except root, which uses `/root`).
- **`/media`**: Standard location for automatically mounting devices, particularly removable media.
- **`/lib`**: Contains shared libraries required by applications in `/bin` and `/sbin` to boot the system.
- **`/mnt`**: A common mount point for devices, often used for temporarily mounting local or remote filesystems.
- **`/misc`**: Sometimes used to automatically mount filesystems upon request.
- **`/opt`**: Used to store add-on application software.
- **`/proc`**: Contains information about system resources.
- **`/root`**: The home directory for the root user, located outside `/home` for security reasons.
- **`/sbin`**: Contains administrative commands and daemon processes.
- **`/tmp`**: Contains temporary files used by applications.
- **`/usr`**: Contains user documentation, games, graphical files (X11), libraries, and other commands and files not needed during the boot process.
- **`/var`**: Contains directories of data used by various applications, including FTP server files (`/var/ftp`), web server files (`/var/www`), system log files (`/var/log`), and spool files (`/var/spool`).


