#/bin/bash
# ============================================
#  log_analyser.sh - Security Log Analyser
#  CloudGuard Phase 1  | Day 13  | Prajwal CK
#
#  What it does:
#  - Finds failed SSH login attempts
#  - Detects top attacking IPs
#  - Checks root login attempts
#  - Monitord sudo abuse
#  - Shows last 5 logins
#
#  Usage: bash log_analyser.sh
# ==============================================
 
# Count security issues found
ISSUES=0

# SSH login log file location
LOG_FILE="/var/log/auth.log"

# Backup log file
SYSLOG="/var/log/syslog"

# Failed attempts before flagging HIGH
THRESHOLD=3

echo "=============================================="
echo " CloudGuard Log Analyser"
echo " Day 13 - Prajwal CK"
echo "=============================================="

# Check 1 - LOG FILE EXISTS
echo ""
echo  "[ LOG CHECK ]"
if [ -f "$LOG_FILE" ]; then
    echo "[OK]      Auth log found: $LOG_FILE"
else
    echo "[WARN]    Auth log not found - using syslog"
    LOG_FILE="$SYSLOG"
fi

# CHECK 2 - FAILED SSH LOGINS
echo ""
echo "[ FAILED SSH LOGINS ]"
FAILED=$(grep "Failed pasword" "$LOG_FILE" 2>/dev/null | wc -l)
if [ -z "$FAILED" ]; then
    FAILED=0
fi
if [ "$FAILED" -gt "$THRESHOLD" ];  then
    echo "[HIGH]    $FAILED failed SSH login attempts"
    ISSUES=$((ISSUES + 1))
    echo ""
    echo " Top attacking IPs:"
    grep "Failed password" "$LOG_FILE" 2>/dev/null |
        awk '{print $11}' |
        sort |
        uniq -c |
        sort -rn |
        head -5 |
        while read count ip; do
            echo" [!] $ip - $count attempts"
        done
else
    echo "[OK]    Failed logins: $FAILED"
fi 

# CHECK 3 - ROOT LOGIN ATTEMPTS
echo ""
echo "[ ROOT LOGIN ATTEMPTS ]"
ROOT_ATTEMPTS=$(grep "Failed password for root" "LOG_FILE" 2>/dev/null  | wc -l)
if [ -z "$ROOT_ATTEMPTS" ]; then
    ROOT_ATTEMPTS=0
fi
if [ "$ROOT_ATTEMPTS" -gt 0 ]; then
    echo "[CRITICAL] $ROOT_ATTEMPTS root login attempts!"
    ISSUES=$((ISSUES + 1))
else
    echo "[OK]      No root login attempts"
fi

# CHECK 4 - SUCCESSFUL LOGINS
echo ""
echo "[ SUCCESSFUL LOGINS ]"
SUCCESS=$(grep -E "Accepted password|Accepted publickey" "$LOG_FILE" 2>/dev/null  | wc -l)
if [  -z "$SUCCESS" ]; then
    SUCCESS=0
fi
echo "[INFO]     $SUCCESS successful logins"

# CHECK 5 - SUDO USAGE
echo ""
echo "[ SUDO USAGE ]"
SUDO_COUNT=$(grep "sudo" "$LOG_FILE" 2>/dev/null  | wc -l)
if [ -z "$SUDO_COUNT" ]; then
    SUDO_COUNT=0
fi 
if [ "$SUDO_COUNT" -gt 10 ]; then
    echo "[MEDIUM] High sudo usage: $SUDO_COUNT events"
    ISSUES=$((ISSUES + 1))
else
    echo "[OK]      Sudo usage: $SUDO_COUNT events"
fi

# CHECK 6 - INVALID USER ATTEMPTS
echo ""
echo "[ INVALID USER ATTEMPTS ]"
INVALID=$(grep "Invalid user" "LOG_FILE" 2>/dev/null  | wc -l)
if [ -z "$INVALID" ]; then
    INVALID=0
fi
if [ "$INVALID" -gt 0 ]; then
    echo "[HIGH]     $INVALID invalid username attempts"
    ISSUES=$((ISSUES + 1))
    echo ""
    echo " Username tried:"
    grep "Invalid user" "$LOG_FILE" 2>/dev/null |
        awk '{print $8}' |
        sort |
        uniq -c |
        sort -rn | 
        head -5 |
        while read count user; do
            echo "  [!] $user - $count attempts"
        done
else
    echo "[OK]      No invalid user attempts"
fi

# CHECK 7 - LAST 5 LOGINS
echo ""
echo "========================================="
echo " Issues Found: $ISSUES"
if [ "$ISSUES" -eq 0 ]; then
    echo  " No security issues in logs!"
elif [ "$ISSUES" -lt 3 ]; then
    echo " Review flagged items above."
else
    echo " URGENT: Multiple issues found!"
fi
echo "========================================="

         