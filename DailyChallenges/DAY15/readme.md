# Day 15 Challenge: Automating Yelb Docker Deployment with GitHub Actions

Hello Learners,

Welcome back to the DevOps SRE Daily Challenge! 🎉

Today, we’re diving into Continuous Integration and Continuous Deployment (CI/CD) by creating a GitHub Actions pipeline for the Yelb application. CI/CD pipelines are the backbone of modern software development, automating repetitive tasks like building, testing, and deploying applications.

By the end of this challenge, you’ll have a working CI/CD pipeline that automates the Yelb application’s lifecycle and understands how to integrate multiple steps in the process.



## What is CI/CD?
- Continuous Integration (CI): Automatically builds and tests your code whenever changes are pushed to the repository.
- Continuous Deployment (CD): Automatically deploys the application to a target environment after successful testing.

## Why Use GitHub Actions for CI/CD?
- Integrated Workflow: Built directly into GitHub, no additional tools are required.
- Customizable: Create workflows tailored to your application’s needs.
- Reusable: Actions can be shared across multiple projects.


## Challenge Requirements
You’ll be enhancing your pipeline with the following steps:
- Image Security Scanning: Use Docker Scout to scan Docker images for vulnerabilities.
- Lint Dockerfiles: Validate the quality of your Dockerfile using Dockerfile Linter.
- Push to Private Registry: Upload Docker images to a private registry (e.g., ECR, GCR, ACR).
- Push Build Artifacts: Store artifacts like logs or manifests in an artifact repository (e.g., JFrog Artifactory).
- Deploy to Lower Environment: Deploy the application to a staging environment for testing.
- Promote to Higher Environment: If tests pass, deploy the application to a production environment.
- Use Slack or email to notify teams about the pipeline's success, failures, or other key milestones.

## Submission Guidelines
1. Proof of Completion:
   - Screenshot of GitHub Actions workflow logs showing all steps executed.
   - Screenshot of the Yelb application running in both environments.
   - Screenshots of reports (Docker lint, scan, build logs).
   - Screenshot of Slack notifications or email updates.
2. Documentation:
   - Describe how reports and notifications improve CI/CD processes.
   - Challenges faced and solutions.
3. Share Your Progress
    - Post your experience on social media with the hashtags: #getfitwithsagar, #SRELife, #DevOpsForAll

## Why This Matters
This challenge teaches you how to build and enhance CI/CD pipelines for real-world scenarios. </br>
Security, linting, and multi-environment deployment ensure your pipeline meets industry standards and prepares you for production-grade systems.


If you missed any previous challenges, you can catch up by reviewing the problem statements on GitHub.


Best regards,</br>
Sagar Utekar
