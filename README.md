# 🛡️ server-hardener

> **Automated Linux Server SECURITY Toolkit** — Audits users, SSH config, disk, processes, logs, and file permissions in one unified bash toolkit.

[![Bash](https://img.shields.io/badge/Bash-4.0%2B-4EAA25?style=flat-square&logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)](LICENSE)
[![Security](https://img.shields.io/badge/Security-Tools-red?style=flat-square)]()
[![CloudGuard](https://img.shields.io/badge/CloudGuard-Phase%201-orange?style=flat-square)](https://github.com/Prajwal18hikify)
[![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20WSL-blue?style=flat-square)]()

-----

## 📖 Overview

**server-hardener** is a command-line Linux security toolkit built for engineers who need fast, automated server security audits without enterprise-tool overhead.

It bundles five focused security scripts into one toolkit — audit users, SSH configuration, disk health, running processes, and security logs in seconds.

> Built as part of the [CloudGuard 150-Day AI Cloud Security Journey](https://github.com/Prajwal18hikify) — Phase 1: Foundations.

-----

## 🔧 Tools Included

|Script           |Purpose                                             |Day Built|
|-----------------|----------------------------------------------------|---------|
|`linux_basics.sh`|System baseline — disk, memory, processes, network  |Day 8    |
|`user_audit.sh`  |User enumeration — current user, all system accounts|Day 9    |
|`ssh_checker.sh` |SSH config audit — root login, password auth, port  |Day 10   |
|`linux_audit.sh` |Full server security audit — SSH, files, disk, users|Day 12   |
|`log_analyser.sh`|Security log analysis — brute force, attacking IPs  |Day 13   |

-----

## ⚠️ Risk Severity Levels

|Level         |Meaning                  |
|--------------|-------------------------|
|🔴 **CRITICAL**|Immediate action required|
|🟠 **HIGH**    |Fix within 24 hours      |
|🟡 **MEDIUM**  |Schedule remediation     |
|🟢 **OK**      |No issues found          |

-----

## ⚙️ Quick Start & Usage

### 1. Requirements

- Linux or WSL (Windows Subsystem for Linux)
- Bash 4.0+
- Run as non-root user with sudo access

### 2. Installation

```bash
# Clone the repository
git clone https://github.com/Prajwal18hikify/server-hardener
cd server-hardener

# Make all scripts executable
chmod +x *.sh
```

-----

### 3. Run Individual Scripts

#### 🖥️ System Baseline Check

Shows disk usage, memory, running processes, and network interfaces.

```bash
bash linux_basics.sh
```

**Sample Output:**

```
==================================
  CloudGuard Linux Basics Audit
==================================

DISK USAGE:
Filesystem      Size  Used Avail Use%
/dev/sda1        50G   12G   38G  24%

MEMORY:
              total    used    free
Mem:           15Gi   4.2Gi   9.8Gi

RUNNING PROCESSES:
USER       PID %CPU %MEM    COMMAND
root         1  0.0  0.0    /sbin/init

Audit Complete
```

-----

#### 👤 User Audit

Shows current user, all system accounts, and running processes.

```bash
bash user_audit.sh
```

**Sample Output:**

```
========================================
  CloudGuard User Audit
  Day 09 — Prajwal CK
========================================

CURRENT USER:
prajwal_ck
uid=1000(prajwal_ck) gid=1000(prajwal_ck)

ALL USERS:
root
daemon
prajwal_ck
```

-----

#### 🔑 SSH Security Checker

Audits SSH configuration for dangerous settings.

```bash
bash ssh_checker.sh
```

**Sample Output:**

```
==================================
  CloudGuard SSH Security Checker
==================================

[ CONFIG CHECK ]
[OK] SSH config found

[ ROOT LOGIN CHECK ]
[OK]       Root SSH disabled

[ PASSWORD AUTH CHECK ]
[OK]       Password auth off — key-based only

==================================
  Issues Found: 0
  SSH looks secure!
==================================
```

-----

#### 🔒 Full Linux Security Audit

Complete server security audit — checks user, disk, SSH, and file permissions.

```bash
bash linux_audit.sh
```

**Sample Output:**

```
==================================
  CloudGuard Linux Security Audit
  Day 12 — Prajwal CK
==================================

[ USER CHECK ]
[OK]       User: prajwal_ck

[ DISK CHECK ]
[OK]       Disk: 24%

[ SSH CHECK ]
[OK]       Root SSH disabled
[OK]       Password auth off

[ FILE CHECK ]
[OK]       NO world-writable files

==================================
  Issues Found: 0
  Server looks secure!
==================================
```

-----

#### 📋 Security Log Analyser

Parses auth.log to find brute force attacks, root attempts, and suspicious activity.

```bash
bash log_analyser.sh
```

**Sample Output:**

```
============================================
  CloudGuard Log Analyser
  Day 13 — Prajwal CK
============================================

[ LOG CHECK ]
[OK]      Auth log found: /var/log/auth.log

[ FAILED SSH LOGINS ]
[HIGH]    47 failed SSH login attempts detected

  Top attacking IPs:
  [!] 192.168.1.100 — 23 attempts
  [!] 10.0.0.55 — 15 attempts
  [!] 172.16.0.22 — 9 attempts

[ ROOT LOGIN ATTEMPTS ]
[CRITICAL] 12 root login attempts detected!

[ SUDO USAGE ]
[OK]      Sudo usage: 3 events

[ INVALID USER ATTEMPTS ]
[HIGH]    18 attempts with invalid usernames

  Usernames being tried:
  [!] 'admin' — 8 attempts
  [!] 'ubuntu' — 6 attempts
  [!] 'test' — 4 attempts

[ LAST 5 LOGINS ]
prajwal_ck  pts/0  Fri May 27 09:00  still logged in

============================================
  Issues Found: 3
  URGENT: Multiple security issues found!
============================================
```

-----

## 📁 Repository Structure

```
server-hardener/
├── linux_basics.sh     # System baseline check
├── user_audit.sh       # User enumeration
├── ssh_checker.sh      # SSH config audit
├── linux_audit.sh      # Full security audit
├── log_analyser.sh     # Security log analysis
└── README.md           # This file
```

-----

## 🗺️ Roadmap

- [x] Phase 1 — Linux security scripts (Days 8–14)
- [ ] Phase 2 — AWS IAM + S3 + EC2 checks
- [ ] Phase 3 — CIS Benchmark mapping
- [ ] Phase 4 — CloudGuard SaaS dashboard
- [ ] Phase 5 — AI-powered remediation (Claude API)

-----

## 🔗 Connection to CloudGuard

Every script in this toolkit becomes a module inside **CloudGuard**:

|Script           |CloudGuard Feature                       |
|-----------------|-----------------------------------------|
|`linux_audit.sh` |Linux baseline check in Phase 4 dashboard|
|`log_analyser.sh`|Anomaly detection engine in Phase 4      |
|`ssh_checker.sh` |SSH misconfiguration check in scanner    |
|`user_audit.sh`  |User enumeration in server audit         |

-----

## ⚠️ Legal Notice

Only run these scripts on systems you own or have explicit written permission to audit. Unauthorized security scanning is illegal.

-----

## 🤝 Contributing

Pull requests welcome. For major changes, open an issue first.

1. Fork the repo
1. Create a feature branch: `git checkout -b feature/your-feature`
1. Commit: `git commit -m 'feat: your feature'`
1. Push: `git push origin feature/your-feature`
1. Open a Pull Request

-----

## 👤 Author

**Prajwal CK**

- GitHub: [@Prajwal18hikify](https://github.com/Prajwal18hikify)
- LinkedIn: [prajwal-ck-cloudguard](https://linkedin.com/in/prajwal-ck-cloudguard)
- Building: CloudGuard — AI-Powered Cloud Security Scanner
- Journey: Biotechnology → AI Cloud Security Engineer (150 Days)
- Location: Bengaluru, India

-----

## 📄 License

MIT License — free to use, modify, and distribute.

-----

> *Part of the CloudGuard 150-Day Journey — Phase 1 of 6*
> *“The five months pass whether you follow this plan or not.”*
