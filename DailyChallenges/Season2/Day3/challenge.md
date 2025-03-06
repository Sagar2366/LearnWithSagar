## Hello Learners,

Welcome to the **DevOps SRE Daily Challenge!** 

Today, we focus on mastering **Git collaboration and version control**, essential skills for DevOps and SRE professionals working in a team environment. You will work on a shared repository, create branches, make changes, resolve merge conflicts, and handle pull requests across **both GitHub and GitLab**.

---

## **Introduction to Version Control**

### What is Version Control System (VCS)?
Version Control Systems (VCS) help developers track changes, collaborate efficiently, and revert to previous versions of the code when needed. The two primary challenges addressed by version control systems are:

1. **Backup and Restore** – Files are safe against accidental losses or mistakes.
2. **Collaboration** – Multiple people can work on the same project simultaneously.
3. **Branching and Merging** – Users can diverge from the main base of code, experiment, and then bring changes back in line without losing work.
4. **Tracking Changes** – You can see specific changes made and by whom.

### Centralized vs. Distributed Version Control

![CVCS-vs-DVCS](https://github.com/user-attachments/assets/16766bbd-d8d4-48a6-8ed7-3d754d0c09be)

Earlier, centralized version control systems like SVN required all code changes to be stored on a central server. This created a single point of failure. Git, a **distributed version control system (DVCS),** allows developers to maintain local repositories and synchronize with a remote repository like GitHub, GitLab, or Bitbucket.

| Feature | Centralized VCS (CVCS) | Distributed VCS (DVCS) |
|---------|----------------------|----------------------|
| Server Dependency | Requires a central server | Each user has a full copy of the repo |
| Offline Work | Limited functionality | Full functionality offline |
| Speed | Slower | Faster |
| Example | SVN | Git |

## **What is Git?**
Git is a distributed version control system (DVCS) that allows multiple people to work on the same project while keeping track of changes. It enables teams to collaborate efficiently, track modifications, and revert to previous versions when needed.

## **What is GitHub and GitLab?**
**GitHub** and **GitLab** are cloud-based Git repository hosting services that provide additional features like pull requests, issue tracking, and CI/CD pipelines. 

- **GitHub** is widely used in open-source communities and enterprise software development.
- **GitLab** provides built-in DevOps features like CI/CD pipelines and project management tools.

## **Why This Matters?** 

Your task today is to learn and apply the following concepts:

- Setting up Git, GitHub, and GitLab accounts for collaboration.
- Forking repositories and creating feature branches.
- Committing, pushing, and reviewing code changes.
- Resolving merge conflicts and updating pull requests.
- Understanding Git concepts like `HEAD`, `origin`, `git diff`, and `git commit --amend`.
- Using two GitHub accounts to simulate code reviews and merging changes.
- Performing the **same** Git workflows on GitLab.

---

## **Why This Matters?** 

Git is the backbone of modern software development and DevOps workflows. Understanding its collaborative features ensures smooth teamwork, fewer merge conflicts, and efficient code reviews. By practicing on both **GitHub and GitLab**, you gain real-world experience in multi-platform version control.

---

## **Challenge Tasks** 

### **1. Set Up the Environment**
## Installing Git

### Windows
1. Download Git from [git-scm.com](https://git-scm.com/downloads).
2. Run the installer and follow the setup wizard.
3. Verify installation by running:
   ```bash
   git --version
   ```

### macOS
1. Install Git using Homebrew:
   ```bash
   brew install git
   ```
2. Verify installation:
   ```bash
   git --version
   ```

### Linux
1. Install Git using the package manager:
   ```bash
   sudo apt install git   # Debian-based systems
   sudo yum install git   # RHEL-based systems
   ```
2. Verify installation:
   ```bash
   git --version
   ```

## Setting Up GitHub and GitLab Accounts

### GitHub
1. Go to [GitHub](https://github.com/) and sign up.
2. Confirm your email address.
3. Create **two GitHub accounts** to simulate code reviews and merging changes.
4. Set up SSH authentication or a Personal Access Token (PAT) for secure access.

### GitLab
1. Go to [GitLab](https://gitlab.com/) and create an account.
2. Confirm your email address.
3. Create a new repository or fork an existing one.
4. Set up SSH authentication for GitLab:
   ```bash
   ssh-keygen -t rsa -b 4096 -C "your.email@example.com"
   ssh-add ~/.ssh/id_rsa
   ```

### **2. Clone and Configure Git**
- **Fork the Repository**: Fork the provided GitHub and GitLab repositories to your own account.
- **Clone the Repository**: Clone the forked repository to your local machine.

```bash
git clone https://github.com/Sagar2366/LearnWithSagar.git
```

- **Configure Git**: Set up your username and email.

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### **3. Create a Feature Branch and Make Changes**
- Create a new branch for your feature.

```bash
git checkout -b feature/your-feature-name
```

- **Make changes and check the differences before staging:**

```bash
git diff
```

- **Stage and commit your changes:**

```bash
git add .
git commit -m "Added new feature: your-feature-name"
```

- **Modify the last commit if needed:**

```bash
git commit --amend -m "Updated commit message with additional changes"
```

### **4. Push Your Changes and Create a Pull Request (PR)**
- **Verify the current branch (HEAD position):**

```bash
git rev-parse --abbrev-ref HEAD
```

- **Push your branch to the remote repository:**

```bash
git push origin feature/your-feature-name
```

- **Create a Pull Request (PR) on GitHub and a Merge Request (MR) on GitLab.**
- **Follow best practices for writing PR descriptions and handling reviews.**

### **5. Resolve Merge Conflicts**
- **Check the current remote repository (origin):**

```bash
git remote -v
```

- Simulate a merge conflict by modifying the same file from another GitHub account.
- Pull the latest changes and merge.

```bash
git checkout main
git pull origin main
git checkout feature/your-feature-name
git merge main
```

- Resolve conflicts manually and commit.

```bash
git add .
git commit -m "Resolved merge conflict in your-feature-name"
```

### **6. Review and Merge**
- **Use your second GitHub account to review and approve the PR.**
- **Perform the same review and merge process on GitLab.**
- Merge the PR once approved.

### **7. Clean Up**
- **Delete your feature branch locally and remotely.**

```bash
git branch -d feature/your-feature-name
git push origin --delete feature/your-feature-name
```

### **8. Viewing Commit Logs**
- View commit history in different formats:

```bash
git log --oneline
git log --pretty=format:"%h - %an, %ar : %s"
git log --stat
```

- Search for specific commit messages:

```bash
git log --grep="fix bug"
```

---

## Summary of Git Commands Used

- **git init**: Initializes a new Git repository.
- **git clone**: Copies a remote repository to your local machine.
- **git config**: Configures user details like name and email.
- **git checkout -b <branch>**: Creates and switches to a new branch.
- **git add .**: Stages all changes for commit.
- **git commit -m "message"**: Saves changes to the repository with a message.
- **git push origin <branch>**: Pushes local changes to a remote repository.
- **git pull origin main**: Fetches and merges the latest changes from the main branch.
- **git merge <branch>**: Merges another branch into the current branch.
- **git log**: Displays the commit history.
- **git diff**: Shows changes between commits, branches, or the working directory and staging area.
- **git branch -d <branch>**: Deletes a local branch.
- **git push origin --delete <branch>**: Deletes a remote branch.
- **HEAD**: Represents the current branch or commit you are working on.
- **origin**: The default name for the remote repository from which the local repository was cloned.


## **Submission Guidelines** 
- Store your findings and execution steps in a markdown file (`challenge_solution.md`).
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

