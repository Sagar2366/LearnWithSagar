```
#!/bin/bash

# Enable debugging if DEBUG is set to true
DEBUG=true
if [ "$DEBUG" = true ]; then
    set -x
fi

# Configuration
EMAIL="getfitwithsagar2366@gmail.com"
REPORT_FILE="/tmp/system_health_report.txt"

# Initialize the report file (clear it at the start)
> "$REPORT_FILE"

# Function to check disk usage
check_disk_usage() {
    echo "=== Disk Usage ===" >> "$REPORT_FILE"
    df -h >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
}

# Function to monitor running services
monitor_services() {
    echo "=== Running Services ===" >> "$REPORT_FILE"
    systemctl list-units --type=service --state=running >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
}

# Function to check memory usage
check_memory_usage() {
    echo "=== Memory Usage ===" >> "$REPORT_FILE"
    free -h >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
}

# Function to check CPU usage
check_cpu_usage() {
    echo "=== CPU Usage ===" >> "$REPORT_FILE"
    top -b -n 1 | head -10 >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
}

# Function to send email using ssmtp
send_email_report() {
    echo "Sending comprehensive report via email..."

    # Check if the report file exists
    if [[ ! -f "$REPORT_FILE" ]]; then
        echo "Error: Report file '$REPORT_FILE' does not exist."
        return 1
    fi

    # Prepare the email content
    local EMAIL_CONTENT=$(cat <<EOF
Subject: System Health Report
From: system@example.com
To: $EMAIL

System Health Report:
$(cat "$REPORT_FILE")
EOF
    )

    # Send the email using ssmtp
    echo "$EMAIL_CONTENT" | ssmtp -v "$EMAIL"

    if [[ $? -eq 0 ]]; then
        echo "Email sent successfully to $EMAIL."
    else
        echo "Error: Failed to send email."
        return 1
    fi
}

# Main menu
while true; do
    echo "================================="
    echo "System Health Check Menu"
    echo "1. Check Disk Usage"
    echo "2. Monitor Running Services"
    echo "3. Assess Memory Usage"
    echo "4. Evaluate CPU Usage"
    echo "5. Send Comprehensive Report via Email"
    echo "6. Exit"
    echo "================================="
    read -p "Select an option (1-6): " choice

    case $choice in
        1)
            check_disk_usage
            ;;
        2)
            monitor_services
            ;;
        3)
            check_memory_usage
            ;;
        4)
            check_cpu_usage
            ;;
        5)
            send_email_report
            ;;
        6)
            echo "Exiting... Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid option. Please select a valid choice."
            ;;
    esac

    read -p "Press Enter to continue..."
done
```
