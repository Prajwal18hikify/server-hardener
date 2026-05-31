#!/bin/bash

echo "==============================="
echo " CloudGuard Linux Security Audit"
echo " Day 12 - Prajwal CK"
echo "================================"

ISSUES=0

echo ""
echo "[ USER CHECK ]"
if [ "$(whoami)" == "root" ]; then
    echo "[CRITICAL] Running as ROOT"
    ISSUES=$((ISSUES + 1))
else
    echo "[OK]       User: $(whoami)"
fi 

echo ""
echo "[ DISK CHECK ]"
DISK=$(df / | tail -1 | awk '{print $5}' | tr -d '%')
if [ "$DISK" -gt "90" ]; then
    echo "[CRITICAL] Disk ${DISK}% full"
    ISSUES=$((ISSUES + 1))
elif [ "$DISK" -gt "80" ]; then
    echo "[HIGH]     Disk ${DISK}% full"
    ISSUES=$((ISSUES + 1))
else
    echo "[OK]        Disk: ${DISK}%"
fi

echo ""
echo "[ SSH CHECK]"
ROOT=$(grep "PermitRootLogin" \
/etc/ssh/sshd_config 2>/dev/null)
if echo "$ROOT" | grep -q "yes"; then
    echo "[CRITICAL] Root SSH ENABLED"
    ISSUES=$((ISSUES + 1))
else
   echo "[OK]         Root SSH disabled"
fi

PASS=$(grep "PasswordAuthentication" \ 
/etc/ssh/sshd_config 2>/dev/null)
if echo "$PASS" | grep -q "yes"; then
    echo "[HIGH]     Password auth ON"
    ISSUES=$((ISSUES + 1))
else
   echo "[OK]       Password auth off"
fi

echo ""
echo "[ FILE CHECK]"
WORLD=$(find/etc -perm -0002 \
-type f 2>/dev/null | wc -l)
if [ "$WORLD" -gt "0" ]; then
    echo "[HIGH]     $WORLD world-writable files"
    ISSUES=$((ISSUES + 1))
else
    echo "[OK]       NO world-writable files"
fi

echo ""
echo "======================================"
echo "  Issues Found: $ISSUES"
if [ "$ISSUES" -eq "0" ]; then
    echo "  Server looks secure!"
else
    echo " Fix $ISSUES issues now!"
fi
echo "====================================="
