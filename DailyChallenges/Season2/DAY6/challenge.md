# Day 6 : GitHub Actions Theory & Practical Challenge

![Untitled design (1)](https://github.com/user-attachments/assets/085eac7f-92a3-4af4-a406-e94fced1e84a)

## **1. What is GitHub Actions?**
GitHub Actions is a CI/CD automation tool that enables developers to automate workflows within their GitHub repositories. It allows you to automate software development workflows, such as building, testing, and deploying applications.

## **2. When Should GitHub Actions Be Used? When Should It Not Be Used?**
### **When to Use GitHub Actions:**
- Automating CI/CD pipelines.
- Running tests automatically on code commits.
- Deploying applications to cloud services (AWS, Azure, GCP, etc.).
- Managing infrastructure as code (Terraform, Ansible, etc.).
- Automating security scans and linting.
- Scheduling periodic jobs (e.g., nightly builds, cron jobs).

### **When Not to Use GitHub Actions:**
- When you need on-premises-only solutions.
- If strict security compliance requires hosting the CI/CD pipeline on internal infrastructure.
- If you need advanced enterprise features available only in other CI/CD tools like Jenkins.

| Feature           | GitHub Actions | Jenkins |
|------------------|---------------|---------|
| Hosting         | Cloud-based (GitHub-hosted runners) | Self-hosted (or cloud-based with effort) |
| Ease of Use     | Simple YAML-based workflows | Requires setup & configuration |
| Integration     | Native GitHub integration | Supports multiple VCS (Git, SVN, etc.) |
| Cost           | Free for public repos, limited free usage for private repos | Requires dedicated infrastructure |
| Plugins        | Built-in Marketplace | Extensive plugin ecosystem |
| Scalability    | Managed by GitHub | Requires manual scaling |

## **3. Steps to Create a GitHub Action**
1. Navigate to your GitHub repository.
2. Click on the `Actions` tab.
3. Choose a predefined template or create a `.github/workflows/main.yml` file.
4. Define your workflow steps using YAML.
5. Commit and push the file to trigger the workflow.

## **4. GitHub Actions Workflow Structure**
A typical GitHub Actions workflow consists of:
- **name**: Name of the workflow.
- **on**: Defines when the workflow should run (e.g., push, pull_request, schedule, workflow_dispatch).
- **jobs**: Contains the tasks to be executed.
- **steps**: Defines individual steps in a job.
- **uses**: Calls an external GitHub Action.
- **run**: Executes custom commands or scripts.

Example:
```yaml
name: Example Workflow
on: push
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      - name: Run a script
        run: echo "Hello, GitHub Actions!"
```

## **5. What is a Job? What is an Action?**
- **Job**: A job is a set of steps that execute in the same runner.
  ```yaml
  jobs:
    build:
      runs-on: ubuntu-latest
      steps:
        - run: echo "This is a job"
  ```

- **Action**: A reusable unit of work within GitHub Actions.
  ```yaml
  steps:
    - name: Use a Docker-based Action
      uses: actions/hello-world-docker-action@v1
  ```

## **6. What Are Inputs and Outputs in GitHub Actions?**
- **Inputs** allow workflows to accept dynamic values.
- **Outputs** store results from one step/job and pass them to another.

Example:
```yaml
jobs:
  example:
    runs-on: ubuntu-latest
    steps:
      - id: step1
        run: echo "::set-output name=myoutput::Hello"
      - run: echo "Output from step1: ${{ steps.step1.outputs.myoutput }}"
```

## **7. General Steps in a GitHub Action**
1. **Checkout Code** → Use `actions/checkout` to fetch repository code.
2. **Authenticate & Authorize** → Configure AWS, Azure, or any required credentials.
3. **Perform Necessary Operations** → Run scripts, deploy applications, execute tests, etc.

## **8. Theory Challenge**
### **Answer the following questions:**
1. What are the key differences between GitHub Actions and Jenkins?
2. Describe the general structure of a GitHub Actions workflow.
3. How to manage variables and secrets in GitHub Actions

## **9. Practical Challenge**
### **Challenge Scenario:**
You are required to create a GitHub Actions workflow that:
1. **Builds and pushes a Docker image** to Docker Hub.
2. **Deploys the application on GitHub Runners**
3. **Validates that the application is running correctly**.
4. **Sends an email notification** with the deployment status.

### **Provided Code:**
#### **app.py**
```python
from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return "Hello, Welcome to Season 2! You are learning GitHub Actions."

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
```

#### **Dockerfile**
```dockerfile
# Use official Python image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy files
COPY app.py /app

# Install Flask
RUN pip install flask

# Expose port 5000
EXPOSE 5000

# Run Flask app
CMD ["python", "app.py"]
```

### **Submission Guidelines:**
- Make a **GitHub repository** for the challenge.
- Take **screenshots** of significant steps.
- Document the **solution** in a `solution.md` file, explaining each step clearly.
- Mention **challenges faced** and how you overcame them.
- Ensure that your repository is well-structured and follows best practices.
- Post your experience on social media with #getfitwithsagar #SRELife #DevOpsForAll.
- Tag us in your posts for visibility and networking.

### **Additional Notes:**
- Make sure to use proper authentication methods while pushing Docker images.
- Structure your workflow efficiently by separating build, deployment, and notification steps.
- Follow security best practices, such as setting permissions and using secrets.
- Ensure logging and error handling are in place to debug issues easily.

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
Sagar Utekar & Raihan



