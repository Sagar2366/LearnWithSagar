# Day5 Challenge: Unlocking Log Secrets: A Deep Dive into awk Mastery

Hello Learners,

Welcome back to the DevOps SRE Daily Challenge! 🎉

Today, you'll dive into mastering the AWK command and regular expressions to analyze real-world, complex log files. Logs are the backbone of system reliability, and analyzing them effectively is a core DevOps skill.

## Challenge Overview
You are tasked with processing a sample log file (user_activity.log) that records user activities on a web application. The log file contains inconsistencies, making it necessary to use AWK and regex to extract relevant information and generate a report.



## Tasks
1. Extract Unique IP Addresses Write an awk command to extract all unique IP addresses, regardless of their position in the log.
2. Extract Usernames Use AWK to extract usernames from the log. Ensure the script captures usernames appearing in different positions.
3. Count HTTP Status Codes Count the occurrences of each HTTP status code (e.g., 200, 404, 500) in the log file and display them in sorted order.
4. Identify Failed Login Attempts Extract all entries with a status code of 403 (indicating failed login attempts), along with their timestamps.
5. Generate a Summary Report Create a summary report including:
```
Total number of unique users.
Total number of requests per user.
Total number of successful requests (status code 200).
Total number of failed requests (status codes 404 and 403).
```

## Why This Matters
Log analysis is crucial for maintaining system health, troubleshooting errors, and ensuring security. 
This challenge will prepare you to process inconsistent log files, a common real-world scenario while leveraging AWK and regex to extract insights.



## Submission Guidelines:
GitHub Repository:
Upload your AWK scripts and the output for each task.
Include a README.md file explaining your approach to each task.

## Share Your Progress:
Post your experience on social media with hashtags: #getfitwithsagar, #SRELife, #DevOpsForAll.

If you missed any of the previous challenges, you can catch up by reviewing the problem statements on GitHub.
</br></br>
Best regards,</br>
Sagar Utekar
