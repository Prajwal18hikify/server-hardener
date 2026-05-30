#!/bin/bash

echo "================================="
echo " CloudGuard Linux Audit"
echo " Day 08 - Prajwal CK"
echo "================================="

echo ""
echo "USER INFO:"
echo "Current user: $(whoami)"
echo "Home folder: $HOME"

echo ""
echo "SYSTEM INFO:"
echo "Date: $(date)"
echo "Hostname: $(hostname)"
uname -a

echo ""
echo "DISK USAGE:"
df -h

echo ""
echo "MEMORY:"
free -h

echo ""
echo "RUNNING PROCESSES:"
ps aux | head -10

echo ""
echo "NETWORK:"
ip addr show

echo ""
echo "================================"
echo "Audit Complete"
echo "================================"




