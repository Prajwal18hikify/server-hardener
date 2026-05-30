#!bin/bash

echo "======================================"
echo " CloudGuard User Audit"
echo " Day 09 - Prajwal CK"
echo "======================================"

echo ""
echo "CURRENT USER:"
whoami
id

echo ""
echo "ALL USERS:"
cat /etc/passwd  | cut -d: -f1

echo ""
echo "PROCESSES:"
ps  aux  |  head -10

echo ""
echo "======================================="
echo " Audit Complete"
echo "======================================="
