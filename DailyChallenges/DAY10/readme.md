# Day 10 Challenge: Monitor RabbitMQ with Prometheus and Grafana

Hello Learners,

Welcome back to the DevOps SRE Daily Challenge! 🎉

Today, we’ll dive into monitoring RabbitMQ using Prometheus and Grafana. By the end of this challenge, you'll have a fully functional RabbitMQ monitoring setup, providing insights into queue performance, node health, and more.

### Built-in Prometheus Support
RabbitMQ ships with built-in Prometheus and Grafana support.
- Prometheus Metrics:
  The rabbitmq_prometheus plugin exposes all RabbitMQ metrics on a dedicated TCP port, in Prometheus text format. These metrics provide deep insights into the state of RabbitMQ nodes and the runtime, enabling informed analysis of RabbitMQ behaviour, applications, and infrastructure.

### Grafana Support
RabbitMQ comes with prebuilt Grafana dashboards to visualize metrics effectively.

Dashboards available:
- Overview Dashboard: General RabbitMQ performance and health.
- Runtime Memory Allocators Dashboard: Insights into memory allocation.
- Inter-Node Communication Dashboard: Erlang distribution metrics for cluster communication.
- Raft Metrics Dashboard: Quorum queue and leader election data.
- Others: Dashboards for specific subsystems and metrics.

These dashboards are opinionated, customizable, and follow best practices to spot health issues quickly and provide detailed system insights.


## Prerequisites
Set Up RabbitMQ with Docker Compose and/or Multinode Cluster

### Docker Compose Setup

Step 1: Clone the Repository with Manifests
To begin, clone the RabbitMQ repository that contains the necessary manifests for RabbitMQ, Prometheus, and Grafana:
```
git clone https://github.com/rabbitmq/rabbitmq-server.git
cd rabbitmq-server/deps/rabbitmq_prometheus/docker
```

Step 2: Run Docker Compose to Set Up RabbitMQ, Prometheus, and Grafana
Use Docker Compose to start the RabbitMQ cluster and Prometheus instance, along with a basic workload to generate meaningful metrics:
```
docker-compose -f docker-compose-metrics.yml up -d
docker-compose -f docker-compose-overview.yml up -d
```

This will start a RabbitMQ cluster, Prometheus, and Grafana with predefined configurations, collecting metrics from RabbitMQ.

Step 3: Access Grafana Dashboard
After the setup, navigate to Grafana’s dashboard page at http://localhost:3000/dashboards.

You will be prompted for login credentials:
```
Username: admin
Password: admin
```
Once logged in, Grafana will recommend changing your password, but you can skip this step for the demonstration.

Navigate to the RabbitMQ Overview dashboard. 
This dashboard visualizes the metrics collected by Prometheus from the RabbitMQ cluster.


### 3 node cluster Setup on AWS EC2
1. Install RabbitMQ on all nodes
Configure RabbitMQ as a cluster across the three EC2 nodes.

2. RabbitMQ Configuration
Give the RabbitMQ cluster a descriptive name so that it can be distinguished from other clusters

3. Enable the Prometheus plugin on all nodes
Enable the RabbitMQ Prometheus plugin to expose metrics.
Run rabbitmq-plugins enable rabbitmq_prometheus on all nodes.
Follow the RabbitMQ Prometheus Plugin Documentation for installation and configuration.

4. Prometheus Configuration
Install Prometheus on a separate EC2 instance or any other machine in the network.
Configure Prometheus to scrape RabbitMQ metrics from each node’s exposed Prometheus endpoint (http://node-ip:15692/metrics).

5. Grafana Configuration
Install Grafana on a separate instance or machine.
Add Prometheus as a data source in Grafana.
Import the RabbitMQ Overview dashboard from Grafana's dashboard repository.

Once you've completed these steps, you’ll have a fully functional RabbitMQ cluster with Prometheus scraping metrics and Grafana providing visualizations. 
For more details, refer to the individual documentation links provided for each component.


## Why This Matters:
By setting up RabbitMQ with Prometheus and Grafana, you will gain deep insights into RabbitMQ’s performance and troubleshoot issues faster. 
These tools provide essential metrics, allowing you to monitor your cluster’s health and performance at scale.



## Submission Guidelines:
- Proof of Completion:
  ### RabbitMQ Cluster:
    Provide a screenshot of your RabbitMQ cluster running with 3 nodes on EC2.
    Show the status of the cluster using ``` rabbitmq-diagnostics cluster_status ```

  ### Prometheus Setup:
    Share a screenshot of the Prometheus dashboard with metrics from the RabbitMQ cluster being scraped.
    Verify that Prometheus is scraping data from each RabbitMQ node (check the Prometheus targets page).

  ### Grafana Setup:
    Provide a screenshot of the Grafana dashboard displaying the RabbitMQ metrics (Overview dashboard).
    Ensure you’ve imported the RabbitMQ Overview dashboard and can visualize metrics like message rates, health indicators, and node stats.

- Documentation:
  ### README.md Updates:
    Include the purpose of the setup, key steps followed, and a brief description of the Prometheus and Grafana dashboards.
    Mention any challenges faced during the setup and how they were overcome.
  ### Monitoring Insights:
    Share any interesting findings or observations based on the metrics from the Grafana dashboard (e.g., high message rates, memory usage, or unbalanced load).
  ### Share Your Progress:
    Post your experience on social media with hashtags: #getfitwithsagar, #SRELife, #DevOpsForAll.

## Bonus Tasks:
  -  Experiment with different load profiles by sending messages to RabbitMQ and observing how the metrics change in Grafana.
  -  Modify the Prometheus scrape interval or the Grafana dashboard thresholds to better fit your environment and workload.
  -  Share any customizations you made to the Grafana dashboards.

If you missed any previous challenges, you can catch up by reviewing the problem statements on GitHub.


Best regards,</br>
Sagar Utekar
