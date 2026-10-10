#!/bin/bash

# ==========================================
# InfraWatch - Linux Infrastructure Monitor
# Version: 1.1
# ==========================================

# Alert thresholds
DISK_THRESHOLD=80
MEMORY_THRESHOLD=80

echo "=========================================="
echo "       InfraWatch Monitoring System"
echo "=========================================="

echo "Hostname: $(hostname)"
echo "Date: $(date)"

# ------------------------------------------
# 1. Disk Usage Monitoring
# ------------------------------------------

echo ""
echo "----- DISK MONITORING -----"

DISK_USAGE=$(df -P / | awk 'NR==2 {gsub(/%/, "", $5); print $5}')

echo "Root disk usage: ${DISK_USAGE}%"

if [ "$DISK_USAGE" -ge "$DISK_THRESHOLD" ]; then
    echo "WARNING: Disk usage is above the threshold!"
else
    echo "OK: Disk usage is normal."
fi

# ------------------------------------------
# 2. Memory Usage Monitoring
# ------------------------------------------

echo ""
echo "----- MEMORY MONITORING -----"

MEMORY_USAGE=$(free | awk '/Mem:/ {printf "%.0f", ($3/$2)*100}')

echo "Memory usage: ${MEMORY_USAGE}%"

if [ "$MEMORY_USAGE" -ge "$MEMORY_THRESHOLD" ]; then
    echo "WARNING: Memory usage is above the threshold!"
else
    echo "OK: Memory usage is normal."
fi

# ------------------------------------------
# 3. System Uptime
# ------------------------------------------

echo ""
echo "----- SYSTEM UPTIME -----"

uptime

# ------------------------------------------
# 4. Final Status
# ------------------------------------------

echo ""
echo "=========================================="
echo "       Monitoring Completed"
echo "=========================================="
