# Day 9 Challenge: Build a Distributed Logging System (Part 2)

Hello Learners,

Welcome back to the DevOps SRE Daily Challenge! 🎉

Today, we’ll continue where we left off yesterday and implement a log producer and consumer system using RabbitMQ. 
By the end of this challenge, you’ll have a distributed logging system that can produce log messages and aggregate them into a file for analysis.

## Requirements:
### Install Required Python Libraries:
``` pip install pika ```

### Create the Producer Script (log_producer.py):
- This script simulates log generation and sends log messages to the RabbitMQ queue.

### Test the Producer:

- Run the producer script to send a log message:

``` python log_producer.py "Log Entry 1: This is a sample log."```

- Create the Consumer Script (log_aggregator.py):
- This script will read log messages from the logs_queue and write them to a file. 

### Test the Consumer:
- Run the consumer script:
``` python log_aggregator.py```
- Send multiple logs using the producer, and confirm the messages are saved in aggregated_logs.txt.

### Verify the Logs:
- Open the aggregated_logs.txt file to ensure all logs are captured.

## Why This Matters
This challenge showcases how RabbitMQ can be used to decouple log production and consumption, creating a scalable and fault-tolerant system. 
Such systems are widely used in real-world applications for log aggregation, task queues, and event-driven architectures.

## Submission Guidelines:
### Proof of Completion:
- Screenshots showing RabbitMQ dashboard with logs in the queue.
- Logs processed by the consumer in the terminal.
- Contents of aggregated_logs.txt.
### Documentation:
- Update your README.md with the purpose of each script, challenges faced, and key learnings.
### Share Your Progress:
- Post your experience on social media with hashtags: #getfitwithsagar, #SRELife, #DevOpsForAll.


## Bonus Tasks:
- Visit the RabbitMQ official [Work Queues tutorial ](https://www.rabbitmq.com/tutorials/tutorial-one-python)
- Follow the instructions to set up producer and worker queues.
- Test the system by running multiple worker instances and observing how tasks are distributed.
- Learn Key Concepts - Message acknowledgement to ensure reliability, Fair dispatch to avoid overloading a single worker, Durable queues and persistent messages to handle failures.

If you missed any previous challenges, you can catch up by reviewing the problem statements on GitHub.

</br>
Best regards,</br>
Sagar Utekar
