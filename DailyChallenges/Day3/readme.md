# Day 3 Challenge: Multi-Service Reverse Proxy with Nginx


Hello Learners,



Welcome back to the DevOps SRE Daily Challenge! 🎉

Today, you’ll explore the power of Nginx by setting up a reverse proxy for multiple services. This hands-on challenge will enhance your skills in configuring secure, efficient, and scalable web access—an essential skill for any DevOps professional!



## Requirements:
### Service Setup: 
- Install and run Grafana and Jenkins locally or via Docker.

### Nginx Reverse Proxy:
- Configure Nginx to route requests:
```
https://grafana.local → Grafana
https://jenkins.local → Jenkins (with Basic Authentication).
```

### Enable SSL:
- Generate and configure a self-signed SSL certificate for HTTPS access.
- Redirect all HTTP traffic to HTTPS.

###  Secure Jenkins:
- Restrict Jenkins/Grafana access with Basic Authentication.

###  Validate Configuration: 
- Access both services via the configured domains securely using HTTPS.


</br>

## Why This Matters:
Reverse proxies are a cornerstone of cloud-native architectures, enabling secure service exposure, load balancing, and high availability. 
This challenge prepares you to handle real-world scenarios where Nginx is critical.


</br>

## Submission Guidelines:
1. GitHub Repository: Upload your Nginx configuration, Grafana and Jenkins setup steps, and screenshots of task completion.

2. Documentation: Include a README.md explaining your approach, challenges faced, and key learnings.

3. Share Your Progress: Post your experience with hashtags: #getfitwithsagar, #SRELife, #DevOpsForAll



## Bonus Tasks: </br></br>
###  Restrict Access to Jenkins by IP:
- Use Nginx’s allow and deny directives to restrict access to Jenkins from a specific IP range (e.g., your office/home IP).
- Only allow access from your designated IP range and deny others.
### Implement Rate Limiting in Nginx:
- Set up Nginx rate limiting to prevent abuse by restricting the number of requests per second from each IP address.
- Ensure that rate limits are applied for access to Jenkins.
### Configure Subdomains:
- Configure Nginx to use subdomains (grafana.local and jenkins.local) instead of path-based routing.
###  Automate Setup with  Shell Scripts:
- Write a shell script that automates the entire process:
- Install and configure Grafana and Jenkins.
- Set up Nginx reverse proxy.
- Create and install SSL certificates.
- Configure Basic Authentication for Jenkins.
- The script should handle all the steps required to set up the environment from scratch.

</br></br>
If you missed any of the previous challenges, you can catch up by reviewing the problem statements on GitHub.

</br></br>
Best regards,</br>
Sagar Utekar
