# Day 6 Challenge: AMI-azing Deployments – Custom Images, Snapshots, and Cross-Region Magic!

Hello Learners,

Welcome back to the DevOps SRE Daily Challenge! 🎉

## Challenge Overview
In today’s challenge, you’ll create a custom AMI, apply security hardening, and deploy it across AWS regions. </br>You will also work with snapshots and volumes, learning to manage and migrate resources efficiently. 
This challenge will help you master key skills for scalability and disaster recovery in the cloud.



## Tasks
1. Create a Custom AMI
   - Launch an EC2 instance in the source region.
   - Install software packages (e.g., web server, monitoring tools).
   - Apply security hardening (e.g., following CIS Benchmarks, AWS Inspector).
   - Bake these changes into a custom AMI.
   - Copy the Custom AMI to Another Region

2. Use the AWS Management Console or AWS CLI to copy the custom AMI to a target region.

3. Launch a New Instance from the Custom AMI

4. Launch a new EC2 instance using the copied AMI in the target region.

5. Prepare a Volume Snapshot
   - Create a snapshot of an existing volume in the source region.
   - Copy the snapshot to the target region.
   - Create and Attach a Volume from the Copied Snapshot

6. In the target region, create a volume using the copied snapshot. Attach this volume to the newly launched instance.

## Why This Matters
Mastering AMI creation, snapshot management, and cross-region deployments ensures system scalability, availability, and resilience. </br>In modern DevOps and SRE practices, managing these resources efficiently helps in disaster recovery, faster deployments, and maintaining consistency across environments.



## Submission Guidelines:
### GitHub Repository:
- Upload your AWS CLI scripts and the output for each task.
- Include a README.md file explaining your approach to solving each task.
### Share Your Progress:
- Post your experience on social media using the hashtags: #getfitwithsagar, #SRELife, #DevOpsForAll.

If you missed any previous challenges, you can catch up by reviewing the problem statements on GitHub.

</br></br>
Best regards,</br>
Sagar Utekar
