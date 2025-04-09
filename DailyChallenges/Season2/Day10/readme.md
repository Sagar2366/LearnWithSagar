# Daily DevOps + SRE Challenge Series – Season 2
## Day 10: Navigating and Managing the Linux Filesystem

### Introduction
Welcome to Day 10 of the Daily DevOps + SRE Challenge Series - Season 2! 🎉

Today, we’re exploring the Linux filesystem—its structure, navigation, and essential file management tools. You’ll master commands to move around, create, copy, move, and delete files, all while building skills critical for DevOps and SRE workflows. By the end, you’ll:
- Understand the filesystem hierarchy and path navigation.
- Gain fluency in tools like `cd`, `mkdir`, `cp`, `mv`, and `rm`.

#### Why This Matters?
Whether you’re deploying apps, troubleshooting outages, or writing scripts these skills are non-negotiable. Here’s why:
- **Universal Skill**: Every Linux system—from cloud instances to Kubernetes pods—relies on the filesystem. Commands like `cd /var/log` or `rm -rf /tmp/cache` work everywhere.
- **Automation Backbone**: Scripts like `mv *.log /archive/$(date +%Y%m%d)` organize logs daily in cron jobs or CI/CD pipelines.
- **SRE Efficiency**: During incidents, `cp -r /etc/nginx /backup` or `find / -name core.*` pinpoints crash dumps fast, saving downtime.
- **Career Boost**: Fluency in filesystem tasks impresses in interviews—think “How do you restore a config?” or “How do you free disk space?”
- **Real-World Example**: An SRE at a fintech firm used `mkdir -p /data/backups/$(date +%F) && cp -r /prod/data/* /data/backups/$(date +%F)` to snapshot critical data before a risky upgrade, averting disaster when it failed.

Let’s dive in and take control of the filesystem!

---

## Challenge Breakdown  
Today, you’re not just learning—you’re on a mission! Imagine you’re an SRE tasked with securing a critical server after a chaotic deployment. You’ll navigate treacherous filesystem paths, manage secret files, attach and secure new storage, and even collaborate with rogue agents (users). By the end, you’ll:
- Navigate and manipulate the filesystem like a stealth operative.
- Secure files, directories, and mounts under pressure.
- Execute advanced ops—linking, archiving, and user management—to outsmart the chaos.

---

## Challenge Description
You’re securing a server after a botched update. Your mission: navigate the filesystem, manage critical files, secure a new storage vault, collaborate with agents, and archive secrets—all while leaving no trace. Ready?

## Theory Questions
Before you dive into the heist, test your knowledge with these questions. They’re based on the filesystem concepts you’ll need to succeed. Write your answers in a file `~/heist_vault/theory_answers.txt` and check them against the solutions later.

1. **Filesystem Hierarchy**: What is the purpose of the `/var` directory, and why might it be mounted on a separate device?
2. **Paths**: Explain the difference between an absolute path and a relative path. Give an example of each that reaches `/home/user/docs` from `/usr/share`.
3. **Wildcards**: If you run `ls f[io]le*` in a directory containing `file1`, `fole2`, `file3`, and `flea`, what files will be listed?
4. **Permissions**: What does `chmod 640 file.txt` do to the permissions of `file.txt`? Describe the resulting access for owner, group, and others.
5. **Mounts**: Why might an administrator mount `/home` with the `noexec` option? What does this prevent?
6. **Copying Files**: How does `cp -a /dir1 /dir2` differ from `cp -r /dir1 /dir2` when copying a directory?
7. **Links**: What’s the difference between a hard link and a symbolic link? Why might a hard link to `/etc/passwd` fail when created in your home directory?
8. **Redirection**: What does `echo "Log entry" >> /var/log/mylog` do? How is it different from using `>`?
9. **Mount Commands**: Compare the output of `mount`, `df -h`, and `findmnt`. Which would you use to check available disk space?
10. **SGID**: What happens to the group ownership of files created in a directory with the SGID bit set (e.g., `chmod g+s`)?

---

### II. Practical

### Task 1: Infiltrate the Filesystem (as `ec2-user`)
- Confirm your entry point with `pwd` (expect `/home/ec2-user`).
- Infiltrate `/var/log` using an absolute path.
- Retreat to `/var` with a relative move.
- Slip back to base (`~`) using a shortcut.
- In one command, hit `/tmp` then bounce back to base, verifying with `pwd`.

### Task 2: Set Up the Hideout (as `ec2-user`)
- Establish `heist_vault` in `~`.
- Create subdirs `newfiles` and `oldfiles` in one command.
- In `newfiles`, plant a hidden file `.secret` and a decoy `decoy.txt` using `touch`.
- Secure `newfiles` with `chmod 700` and verify with `ls -ld`.

### Task 3: Secure the New Vault - Storage Management (Root)
- **Agent Brief**: A new 1GB EBS volume arrives (or simulate with a loop device).
  1. As root: If on AWS, attach a 1GB EBS volume via the console; note the device (e.g., `/dev/xvdf`). If not, create a 1GB loop device: `dd if=/dev/zero of=/root/disk.img bs=1M count=1000; losetup /dev/loop0 /root/disk.img`.
  2. Partition it: `fdisk /dev/xvdf` (or `/dev/loop0`) → `n` (new), `p` (primary), `1` (partition 1), defaults, `w` (write).
  3. Format as ext4: `mkfs.ext4 /dev/xvdf1` (or `/dev/loop0p1`).
  4. Mount at `/data`: `mkdir /data; mount /dev/xvdf1 /data` (or `/dev/loop0p1`).
  5. Verify: `df -h` (shows `/data` usage) and `lsblk` (lists device tree).
- **Tip**: If `lsblk` shows no partitions, recheck `fdisk` steps.

### Task 4: Advanced File Ops Under Pressure (as `ec2-user`)
- From `heist_vault/oldfiles`:
  1. Copy `newfiles` (including `.secret`) into `oldfiles` with `cp -a ../newfiles/ .`.
  2. Remove the nested `newfiles` with `rm -rf newfiles`.
  3. Copy only visible files from `../newfiles` using `cp -a ../newfiles/* .`.
  4. Copy hidden files separately with `cp -a ../newfiles/. .` and verify with `ls -a`.
- In `~`:
  5. Create `projects` with `house1` to `house9` using brace expansion.
  6. List only `house*` files (exclude others like `heist_vault`).
  7. Build `$HOME/projects/houses/doors/` and plant:
     - `$HOME/projects/houses/bungalow.txt`
     - `$HOME/projects/houses/doors/bifold.txt`
     - `$HOME/projects/outdoors/vegetation/landscape.txt`
  8. Copy `house1` and `house5` to `houses/`.
  9. Recursively copy `/usr/share/doc/initscripts*` to `projects/` with `-a`.
  10. List `projects/` recursively, paging with `less`.
  11. Wipe `house6` to `house8` non-interactively.
  12. Move `house3` and `house4` to `doors/`.
  13. Obliterate `doors/` and its contents.
  14. Set `house2` perms to owner `rw`, group `r`, others none.
  15. Recursively block write access to `projects/` for all.

### Task 5: Agent Collaboration (Root + Users)
- As root:
  1. Create group `agents`.
  2. Add users `alice` and `bob` to `agents` with home dirs and passwords.
  3. Establish `/data/shared_space`.
  4. Assign group `agents` with `chgrp`.
  5. Set perms to `770`.
  6. Enable SGID with `chmod g+s`.
- As `alice`: Create `alice_file.txt` in `/data/shared_space`.
- As `bob`: Create `bob_file.txt` in `/data/shared_space`.
- Verify: `ls -l` shows both files group-owned by `agents`.

### Task 6: Cover Your Tracks with Links (as `ec2-user`)
- In `~`:
  1. Try hard-linking `/etc/passwd` to `passwd_hard` (expect denial).
  2. Soft-link `/etc/passwd` to `passwd_link`.
  3. Soft-link `/etc/hosts` without a target dir (default to current dir).
- In `heist_vault`:
  4. Create `evidence.txt`.
  5. Hard-link it to `evidence_copy` and check link count with `ls -l`.
  6. Soft-link it to `evidence_sym`.
  7. Delete `evidence.txt`.
  8. Test `cat evidence_sym` (broken) and `cat evidence_copy` (works).
  9. Restore `evidence.txt` from `evidence_copy` with `ln`.
  10. Verify with `ls -l`.

### Task 7: Archive the Loot (Root)
- As root:
  1. Archive `/etc` to `/root/etc.tar` (uncompressed).
  2. Check type with `file`.
  3. Compress to `etc.tar.gz` with `gzip`.
  4. List contents with `tar tvf`.
  5. Extract `/etc/hosts` to `/root`.
  6. Verify with `ls -R /root/etc/`.
  7. Decompress `etc.tar.gz`.
  8. Extract `/etc/passwd` to `/tmp` with dir structure.
  9. Confirm with `ls -l /tmp/etc/passwd`.
  10. Create bzip2 archive of `/home` as `/root/homes.tar.bz2`.
  11. Clean up archives from `/root`.

### Task 8: Root Shell Heist (as `student` → Root)
- As `student`:
  1. Escalate to root with `sudo -i`.
  2. Archive `/home` and `/etc` to `/root/essentials.tar`.
  3. Copy to `/tmp`.
  4. Hard-link it to `/essentials.tar`.
  5. Rename to `/archive.tar`.
  6. Soft-link from `/root/link.tar` to `/archive.tar`.
  7. Delete `/archive.tar` and observe `link.tar`.
  8. Remove `link.tar`.
  9. Compress `/root/essentials.tar` to `.gz`.

---
