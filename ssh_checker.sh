#!/bin/bash

echo "========================================"
echo " CloudGuard SSH Security Check"
echo " Day 10 - Prajwal CK"

ISSUES=0

echo ""
echo "CHECKING SSH CONFIG..."
echo ""

# Check 1 - Root login
ROOT=$(grep "PermitRootLogin" /etc/ssh/sshd_config 2>/dev/null)
if echo "$ROOT"  | grep -q "yes"; then 
    echo "[CRITICAL] Root login ENABLED"
    echo "           Fic: PermitRootLogin no"
    ISSUES=$((ISSUES + 1))
else
    echo "[OK]          Root login disabled"
fi

# Check 2 - Passsword auth
PASS=$(grep "PasswordAuthentication" /etc/ssh/sshd_config 2>/dev/null)
if echo "$PASS"  | grep -q "yes"; then
    echo "[HIGH]      Password auth ENABLED"
    echo "            Fix : Use SSH Keys only"
    ISSUES=$((ISSUES + 1))
else
    echo "[OK]        Password auth disabled"
fi

# Check 3 - SSH Port
Port=$(grep "^Port" /etc/ssh/sshd_config 2>/dev/null)
if echo "$PORT"  | grep -q "22"; then
    echo "[MEDIUM]  Default port 22 used"
    echo "          Fix: Change to custom port"
    ISSUES=$((ISSUES + 1))
else
    echo "[OK]       Custom SSH port used"
fi 

echo ""
echo "===================================="
echo "  Issues Found: $ISSUES"
if [ "$ISSUES" -eq "0"]; then
    echo " SSH looks secure!"
else 
    echo " Fix $ISSUES issues now!"
fi 
echo "===================================="