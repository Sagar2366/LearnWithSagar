# Configure SMTP on EC2 Instance:
This guide explains how to configure ssmtp on a Linux system to send emails using Gmail's SMTP server.

## Prerequisites
1. A Gmail account with 2-Step Verification enabled. An App Password generated for ssmtp.
2. Linux System: A Linux-based system (e.g., Amazon Linux 2, Ubuntu, etc.).
    - Root or sudo access.
    - ssmtp Installed: Ensure ssmtp is installed on your system.

### Step 1: Enable 2-Step Verification
Go to your Google Account Security Page.
Under Signing in to Google, click 2-Step Verification.
Follow the prompts to enable 2-Step Verification.

### Step 2: Generate an App Password
Go to your Google Account Security Page.
Under Signing in to Google, click App Passwords.
If you don’t see this option, ensure 2-Step Verification is enabled.
Sign in to your Google account if prompted.
Under Select app, choose Mail.
Under Select device, choose Other (Custom name).
Enter a name for the app password (e.g., ssmtp).
Click Generate.
Google will display a 16-character App Password. Copy this password.

### Step 3: Install ssmtp
Install ssmtp on your Linux system:
```
sudo yum install ssmtp -y  # For Amazon Linux 2
sudo apt install ssmtp -y  # For Ubuntu/Debian
```

### Step 4: Configure ssmtp
Open the ssmtp.conf file for editing: sudo vi /etc/ssmtp/ssmtp.conf
Add the following configuration (replace placeholders with your Gmail credentials):
```
root=your-email@gmail.com
mailhub=smtp.gmail.com:587
AuthUser=your-email@gmail.com
AuthPass=your-16-character-app-password
UseTLS=YES
UseSTARTTLS=YES
rewriteDomain=gmail.com
hostname=localhost
FromLineOverride=YES
```
Save and exit the file.

### Step 5: Test Email Sending
```
echo -e "Subject: Test Email\n\nThis is a test email." | ssmtp -v your-email@gmail.com
Check your Gmail inbox (and Spam folder) for the test email.
```


# Script:
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
