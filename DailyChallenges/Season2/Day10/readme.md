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


## Challenge Breakdown  

### ** Theoretical Questions**  
### Scenario

You are a Linux system administrator entrusted with managing an EC2 instance for a software development team. Your goal is to master essential Linux skills, secure the environment, and prepare for real-world challenges, using practical exercises instead of focusing on specific certifications or exam preparation.

### I. Theory

These questions are designed to assess your understanding of fundamental Linux concepts.

1. You need to locate configuration files. Where do you look?
2. How do you list the newest files first in a directory?
3. Rename `myfile` to `yourfile`.
4. Wipe an entire directory structure.
5. Create a link to `/tmp` in your home directory.
6. Copy files starting with a, b, or c from `/etc` to your current directory.
7. Create a link to `/etc` in your home directory.
8. Safely remove a symbolic link to a directory.
9. Create a compressed archive of `/etc` and `/home` as `/tmp/etchome.tgz`.
10. Extract `/etc/passwd` from `/tmp/etchome.tgz`.

### II. Practical

These tasks require you to perform specific actions on a Linux system.

#### A. Storage Management

1. Attach a new EBS volume to your EC2 instance.
2. Create a partition on the new disk.
3. Create an ext4 filesystem on the partition.
4. Mount the filesystem to a directory named `/data`.
5. Verify the mount using `df -h` and `lsblk`.

#### B. Basic File & Directory Operations (as `ec2-user`)

1. Log in as the `ec2-user`.
2. Use `pwd` to verify you're in `/home/ec2-user`.
3. Create `newfiles` and `oldfiles` directories.
4. Create a hidden file `.hidden` and a regular file `unhidden` within `newfiles`.

#### C. Advanced File & Directory Manipulation (as `ec2-user`)

1. From `oldfiles`, copy `newfiles` (including hidden files) into `oldfiles` using `cp -a ../newfiles/ .`.
2. Remove `newfiles` from within `oldfiles` using `rm -rf newfiles`.
3. Copy only visible files from `../newfiles` into `oldfiles` using `cp -a ../newfiles/* .`.
4. Copy hidden files separately using `cp -a ../newfiles/. .`.
5. In your home directory, create `projects`. Within it, create nine empty files named `house1` through `house9`. List *only* those files, even with other files present.
6. Create the path `$HOME/projects/houses/doors/`. Create these files:
    * `$HOME/projects/houses/bungalow.txt`
    * `$HOME/projects/houses/doors/bifold.txt`
    * `$HOME/projects/outdoors/vegetation/landscape.txt`
7. Copy `house1` and `house5` to `$HOME/projects/houses/`.
8. Recursively copy `/usr/share/doc/initscripts*` to `$HOME/projects/`, preserving attributes.
9. Recursively list `$HOME/projects/`, paging with `less`.
10. Remove `house6`, `house7`, and `house8` non-interactively.
11. Move `house3` and `house4` to `$HOME/projects/houses/doors/`.
12. Remove `$HOME/projects/houses/doors/` and its contents.
13. Set permissions on `$HOME/projects/house2`: owner read/write, group read-only, others no access.
14. Recursively restrict write access to `$HOME/projects/` for everyone.

#### D. User & Group Management and Collaboration (as root, `alice`, and `bob`)

1. As root, create a `developers` group.
2. As root, create users `alice` and `bob`, adding them to `developers`.
3. As root, create `/data/shared_space`.
4. As root, set group ownership of `/data/shared_space` to `developers` with `chgrp`.
5. As root, set permissions on `/data/shared_space` to 770.
6. As root, enable the SGID bit on `/data/shared_space`.
7. As `alice`, create `alice_file.txt` in `/data/shared_space`.
8. As `bob`, create `bob_file.txt` in `/data/shared_space`.
9. Confirm both files are group-owned by `developers`.

#### E. Link Exploration (as `ec2-user`)

1. Attempt to hard link `/etc/passwd` in your home directory (expect permission denied).
2. Create a symbolic link to `/etc/passwd` using `ln -s`.
3. Create a symbolic link to `/etc/hosts` (without specifying a target directory).
4. Create `newfile` using `touch`.
5. Create a hard link `linkedfile` to `newfile` using `ln`.
6. Use `ls -l` to view link counts.
7. Create a symbolic link `symlinkfile` to `newfile` using `ln -s`.
8. Remove `newfile` using `rm`.
9. Attempt `cat symlinkfile` (expect error).
10. `cat linkedfile`.
11. Use `ls -l` to examine `symlinkfile` and `linkedfile`.
12. Restore `newfile` using `ln linkedfile newfile`.
13. Verify the original state using `ls -l`.

#### F. Archiving & Compression (as root)

1. Create an uncompressed tar archive of `/etc` as `/root/etc.tar` using `tar cvf`.
2. Verify the archive type using `file`.
3. Compress `/root/etc.tar` to `/root/etc.tar.gz` using `gzip`.
4. List contents of `/root/etc.tar.gz` without extracting using `tar tvf`.
5. Extract `/etc/hosts` only from `/root/etc.tar.gz` to `/root`.
6. Use `ls -R` to see the extracted file in `/root/etc/`.
7. Decompress `/root/etc.tar.gz` using `gunzip`.
8. Extract `/etc/passwd` from `/root/etc.tar` to `/tmp`, preserving directory structure, using `tar xvf -C`.
9. Verify using `ls -l /tmp/etc/passwd`.
10. Create a bzip2 compressed archive of `/home` as `/root/homes.tar.bz2` using `tar cjvf`.
11. Remove archive files from `/root`.

#### G. Root Shell Operations & File Management

1. As user `student`, use `sudo -i` to become root. Create `/root/essentials.tar` containing `/home` and `/etc`.
2. Copy the archive to `/tmp`. Create a hard link to the archive in `/`.
3. Rename `/essentials.tar` to `/archive.tar`.
4. Create a symbolic link `link.tar` in `/root` pointing to `/archive.tar`.
5. Remove `/archive.tar`. Observe the symbolic link. Remove the symbolic link.
6. Compress `/root/essentials.tar`.

### Deliverables

* Answers to all theory questions.
* A script (or well-documented sequence of commands) that accomplishes all practical tasks.
* Screenshots showing successful execution of key tasks.
* Contents of `/etc/fstab` (if modified).
* Explanations of commands, reasoning, and troubleshooting.
* Demonstration of SGID functionality.
* Verification steps for links and archiving.
* Observations of symbolic link behavior after target removal.
