#!/bin/bash

# InfraWatch - Linux System Monitoring

echo "=================================="
echo "       InfraWatch Monitor"
echo "=================================="

echo "Hostname: $(hostname)"
echo "Date: $(date)"

echo ""
echo "----- UPTIME -----"
uptime

echo ""
echo "----- MEMORY USAGE -----"
free -h

echo ""
echo "----- DISK USAGE -----"
df -h /

echo ""
echo "----- CPU INFORMATION -----"
top -bn1 | grep "%Cpu"

echo ""
echo "Monitoring completed!"
