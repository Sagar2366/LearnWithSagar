```
#!/bin/bash

# Enable debugging if DEBUG is set to true
DEBUG=true
if [ "$DEBUG" = true ]; then
    set -x
fi

EMAIL="sutekar@omnissa.com"

REPORT_FILE="/tmp/system_health_report.txt"

check_disk_usage() {
    echo "=== Disk Usage ===" >> $REPORT_FILE
    df -h >> $REPORT_FILE
    cat $REPORT_FILE
}

monitor_services() {
    echo "=== Running Services ===" >> $REPORT_FILE
    systemctl list-units --type=service --state=running >> $REPORT_FILE
    cat $REPORT_FILE
}

check_memory_usage() {
    echo "=== Memory Usage ===" >> $REPORT_FILE
    free -h >> $REPORT_FILE
    cat $REPORT_FILE
}

check_cpu_usage() {
    echo "=== CPU Usage ===" >> $REPORT_FILE
    top -b -n 1 | head -10 >> $REPORT_FILE
    cat $REPORT_FILE
}

send_email_report() {
    echo "Sending comprehensive report via email..."
    {
        echo "Subject: System Health Report"
        echo "System Health Report:"
        cat $REPORT_FILE
    } | sendmail -i -v -Am $EMAIL
}

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
done
```
