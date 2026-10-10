#!/bin/bash

# ==========================================
# InfraWatch - Linux Infrastructure Monitor
# Version: 1.2
# ==========================================

# Thresholds
DISK_THRESHOLD=80
MEMORY_THRESHOLD=80

# Project directories
PROJECT_DIR="$HOME/InfraWatch"
REPORT_DIR="$PROJECT_DIR/reports"
LOG_DIR="$PROJECT_DIR/logs"

# Timestamp
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
CURRENT_TIME=$(date '+%Y-%m-%d %H:%M:%S')

# Output files
REPORT_FILE="$REPORT_DIR/report_${TIMESTAMP}.txt"
LOG_FILE="$LOG_DIR/monitoring.log"

# Create directories if missing
mkdir -p "$REPORT_DIR" "$LOG_DIR"

# Write report header
{
    echo "=========================================="
    echo "       InfraWatch Monitoring Report"
    echo "=========================================="
    echo "Hostname: $(hostname)"
    echo "Date: $CURRENT_TIME"
    echo ""

    # Disk monitoring
    echo "----- DISK MONITORING -----"

    DISK_USAGE=$(df -P / | awk 'NR==2 {
        gsub(/%/, "", $5)
        print $5
    }')

    if [[ "$DISK_USAGE" =~ ^[0-9]+$ ]]; then
        echo "Root disk usage: ${DISK_USAGE}%"

        if (( DISK_USAGE >= DISK_THRESHOLD )); then
            echo "WARNING: Disk usage is high!"
            echo "[$CURRENT_TIME] WARNING: Disk usage is ${DISK_USAGE}%" \
                >> "$LOG_FILE"
        else
            echo "OK: Disk usage is normal."
        fi
    else
        echo "ERROR: Could not read disk usage."
        echo "[$CURRENT_TIME] ERROR: Disk usage check failed" \
            >> "$LOG_FILE"
    fi

    echo ""

    # Memory monitoring
    echo "----- MEMORY MONITORING -----"

    MEMORY_USAGE=$(free | awk '/^Mem:/ {
        printf "%.0f", ($3/$2)*100
    }')

    if [[ "$MEMORY_USAGE" =~ ^[0-9]+$ ]]; then
        echo "Memory usage: ${MEMORY_USAGE}%"

        if (( MEMORY_USAGE >= MEMORY_THRESHOLD )); then
            echo "WARNING: Memory usage is high!"
            echo "[$CURRENT_TIME] WARNING: Memory usage is ${MEMORY_USAGE}%" \
                >> "$LOG_FILE"
        else
            echo "OK: Memory usage is normal."
        fi
    else
        echo "ERROR: Could not read memory usage."
        echo "[$CURRENT_TIME] ERROR: Memory check failed" \
            >> "$LOG_FILE"
    fi

    echo ""

    # System uptime
    echo "----- SYSTEM UPTIME -----"
    uptime

    echo ""
    echo "=========================================="
    echo "       Monitoring Completed"
    echo "=========================================="

} > "$REPORT_FILE"

# Display the report in the terminal
cat "$REPORT_FILE"

# Record successful report generation
if [[ -s "$REPORT_FILE" ]]; then
    echo "[$CURRENT_TIME] INFO: Report generated: $REPORT_FILE" \
        >> "$LOG_FILE"
    echo ""
    echo "Report saved to: $REPORT_FILE"
    echo "Log saved to: $LOG_FILE"
else
    echo "ERROR: Report generation failed."
    echo "[$CURRENT_TIME] ERROR: Report generation failed" \
        >> "$LOG_FILE"
    exit 1
fi
