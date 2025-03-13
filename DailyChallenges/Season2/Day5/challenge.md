## Hello Learners,

Welcome to the **DevOps SRE Daily Challenge!** 


GitHub is the backbone of modern DevOps workflows, but securing your repositories is crucial to prevent accidental leaks, unauthorized changes, and security vulnerabilities. 
Today’s challenge is all about GitHub security best practices.


## **Objective**
Create a secure and collaborative GitHub environment for a sample project. Learners will:
1. Set up a GitHub organization and manage user access.
2. Enable security features for repositories.
3. Implement PR validation and code owner reviews.
4. Restrict direct commits to the main branch.
5. Enforce proper commit messages in PRs.
6. Require approval from 2 code owners for merging.
7. Ensure all security checks pass before merging.
8. Use Coderabbit for AI-powered code reviews.
9. Use a bot for additional code reviews.
10. Use GitHub Secrets for sensitive information.
11. Integrate vulnerability scanning tools like Snyk for dependency checks.

## Supply chain security: https://docs.github.com/en/code-security/supply-chain-security/understanding-your-software-supply-chain/about-supply-chain-security#what-is-dependabot

## **Challenge Tasks** 
### **1. Set Up a GitHub Organization and Manage Access**
### 1. Create a GitHub Organization:
- Create a new organization on GitHub.
- Name it DevOps-Challenge-Org.

### Invite Users:
- Invite at least 5 users to the organization.

### Create Teams:
Create 3 teams:
- Developers: For developers who will write code.
- DevOps: For DevOps engineers who will manage infrastructure.
- QA: For testers who will review and test code.

### Assign Repository Permissions:
Create a new repository called sample-project.
Assign permissions:
```
Developers: Write access.
DevOps: Admin access.
QA: Read access.
```

### Enable Two-Factor Authentication (2FA):
Enforce 2FA for all organization members.



### **2. Enable Security Features for Repositories**
- Enable Dependabot Alerts:
  - Go to the sample-project repository → Settings → Security & analysis.
  - Enable Dependabot alerts.
  - Enable Secret Scanning: In the same Security & analysis section, enable Secret scanning.
  - Set Up Branch Protection Rules: Go to Settings → Branches → Add branch protection rule.
  - Protect the main branch by enabling:
    - Require a pull request before merging.
    - Require approvals (set to 2).
    - Require status checks to pass before merging.
    - Include administrators.


### **3. Implement PR Validation and Code Owner Reviews**
- Create a CODEOWNERS File:
  - In the sample-project repository, create a .github/CODEOWNERS file.
  - Add the following rules:
```
# Code owners for specific files/directories
*.js @DevOps-Challenge-Org/Developers @DevOps-Challenge-Org/DevOps
/infrastructure/ @DevOps-Challenge-Org/DevOps @DevOps-Challenge-Org/QA
```

- Require Code Owner Reviews:
  - Go to Settings → Branches → Edit branch protection rule for main.
  - Enable Require review from Code Owners.
- Test the Workflow:
  - Create a new branch, make changes to a .js file, and open a PR.
  - Ensure the PR cannot be merged without approval from 2 code owners.


### **4. Restrict Direct Commits to the main Branch**
- Enable Branch Protection Rules:
    - Go to the sample-project repository → Settings → Branches → Add branch protection rule. 
    - Select the main branch.
      - Enable the following options:
        - Require a pull request before merging.
        Require approvals (set to 2).
        Require status checks to pass before merging.
        Include administrators.

  - Test the Restriction: Try to push directly to the main branch. It should be blocked.


### **5. Enforce Proper Commit Messages in PRs**
- Create a Commit Message Policy:
  - Define a commit message format (e.g., type(scope): description).
    Example: feat(login): add user authentication.
  - Share this policy with your team.
  - Manually Review Commit Messages:
  - During PR reviews, ensure all commit messages follow the defined format.


### **6. Require Approval from 2 Code Owners**
- Update the CODEOWNERS File:
- Ensure the .github/CODEOWNERS file defines code owners for all relevant files/directories.
  Example:
```
# Code owners for specific files/directories
*.js @DevOps-Challenge-Org/Developers @DevOps-Challenge-Org/DevOps
/infrastructure/ @DevOps-Challenge-Org/DevOps @DevOps-Challenge-Org/QA
```

- Enable Code Owner Reviews:
  - Go to Settings → Branches → Edit branch protection rule for main.
  - Enable Require review from Code Owners.
  - Set Minimum Number of Approvals:
    - In the same branch protection rule, set Required number of approvals before merging to 2.

- Test the Workflow: Create a PR and ensure it cannot be merged without approval from 2 code owners.


### **7. Ensure All Security Checks Pass Before Merging**
- Enable Required Status Checks:
  - Go to Settings → Branches → Edit branch protection rule for main.
  - Under Require status checks to pass before merging, enable: Dependabot alerts & Secret scanning.
  - Test the Workflow: Create a PR and ensure it cannot be merged if any security checks fail.


### **8. Use Coderabbit for AI-Powered Code Reviews**
- Sign Up for Coderabbit:
  - Go to Coderabbit and sign up using your GitHub account.
  - Install Coderabbit in Your Repository:
  - Follow the instructions on the Coderabbit GitHub page to install the Coderabbit app in your sample-project repository.
  - Grant the necessary permissions for Coderabbit to access your repository.
- Configure Coderabbit:
  - Create a .coderabbit.yaml file in your repository to customize Coderabbit’s behavior (optional).
Example configuration:

```
review:
  enabled: true
  rules:
    - type: code-quality
      severity: warning
```

- Test Coderabbit:
  - Create a new PR with some code changes.
  - Coderabbit will automatically review the PR and provide feedback in the comments.

### **9. Use a Bot for Additional Code Reviews**
- Set Up a Bot Account:
  - Create a new GitHub account for the bot (e.g., code-review-bot).
  - Generate a Personal Access Token (PAT) for the bot with repo permissions.
- Install a Code Review Tool:
  - Use a third-party tool like Dependabot or CodeClimate.
- For Dependabot: Go to Settings → Security & analysis → Enable Dependabot alerts and Dependabot security updates.
- For CodeClimate: Sign up on CodeClimate and connect the sample-project repository. Configure the .codeclimate.yml file to define review rules.
- Test the Bot: Create a PR and ensure the bot comments or approves/rejects based on the rules.

### **10. Use GitHub Secrets for Sensitive Information**
- Store Secrets in GitHub:
  - Go to the sample-project repository → Settings → Secrets and variables → Actions → New repository secret.
  - Add secrets like DATABASE_PASSWORD, API_KEY, etc.
  - Use Secrets in Your Code:
    Create a sample script (e.g., deploy.sh) that uses the secrets.
Example:
```
#!/bin/bash
echo "Deploying with API Key: $API_KEY"
echo "Database Password: $DATABASE_PASSWORD"
```

- Test the Workflow: Run the script in a local environment by setting the secrets as environment variables. Ensure the script can access the secrets securely.

### **11. Integrate Snyk for Vulnerability Scanning**
- Sign Up for Snyk:
  - Go to Snyk and sign up using your GitHub account.
- Install Snyk in Your Repository:
  - Follow the instructions on the Snyk website to connect your GitHub repository.
  - Grant the necessary permissions for Snyk to access your repository.

- Configure Snyk: Create a .snyk file in your repository to customize Snyk’s behavior (optional).

Example configuration:
```
# .snyk file
version: v1.13.5
ignore:
  'SNYK-JS-LODASH-567746':
    - '*':
        reason: 'No immediate fix available'
        expires: '2023-12-31T00:00:00.000Z'
```

- Run Snyk Scans: Use the Snyk CLI to run vulnerability scans on your dependencies.

Example command:

``` snyk test```

- Integrate Snyk with GitHub:
  - Go to your repository → Settings → Security & analysis → Snyk.
  - Enable Snyk vulnerability scanning.

- Test the Workflow: Create a PR and ensure Snyk scans the dependencies. Check the PR for Snyk’s vulnerability report.

### **12. Audit User Activity**
- Check the Audit Log: Go to the organization → Settings → Audit log.
- Review the logs to see actions performed by users (e.g., repository access changes, team modifications).



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

-----------

**Best regards,**  
Sagar Utekar
