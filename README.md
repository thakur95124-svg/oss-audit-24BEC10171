# OSS Audit — Linux Kernel
### Open Source Software (NGMC) | Capstone Project

| Field | Details |
|-------|---------|
| **Student Name** | Thakur Shubham Kumar |
| **Registration No.** | 24BEC10171 |
| **Course** | Open Source Software |
| **Chosen Software** | Linux Kernel |
| **License** | GNU General Public License v2 (GPL-2.0) |

---

## About This Project

This repository contains the five shell scripts for the **Open Source Audit** capstone project. The audit subject is the **Linux Kernel** — the open-source operating system kernel created by Linus Torvalds in 1991 and licensed under GPL v2. The report (submitted separately as a PDF) covers the kernel's origin, philosophy, license analysis, Linux footprint, FOSS ecosystem, and comparison with proprietary alternatives.

---

## Repository Structure

```
oss-audit-24BEC10171/
├── README.md                            ← This file
├── script1_system_identity.sh           ← System welcome screen & kernel info
├── script2_foss_inspector.sh            ← Package inspector with philosophy notes
├── script3_disk_permission_auditor.sh   ← Directory audit with kernel paths
├── script4_log_analyzer.sh             ← Log file keyword scanner
└── script5_manifesto_generator.sh       ← Interactive manifesto generator
```

---

## Scripts Overview

### Script 1 — System Identity Report
Displays a formatted welcome screen with the Linux distribution name, kernel version, current user, home directory, system uptime, date/time, and the open-source license governing the OS.

**Concepts used:** variables, `echo`, command substitution `$()`, `uname`, `whoami`, `uptime`, `hostname`, `date`, `grep`, `cut`

**Run:**
```bash
chmod +x script1_system_identity.sh
./script1_system_identity.sh
```

---

### Script 2 — FOSS Package Inspector
Checks whether a given FOSS package is installed on the system, displays its version and license details, and uses a `case` statement to print an open-source philosophy note for known packages.

**Concepts used:** `if-then-else`, `case` statement, `rpm -qi`, `dpkg -s`, `grep -E`, pipe (`|`), command-line arguments (`$1`)

**Run:**
```bash
chmod +x script2_foss_inspector.sh

# Check a specific package
./script2_foss_inspector.sh bash
./script2_foss_inspector.sh git
./script2_foss_inspector.sh httpd

# Run with no argument (defaults to 'bash')
./script2_foss_inspector.sh
```

**Dependencies:** `rpm` (RHEL/Fedora) or `dpkg` (Debian/Ubuntu) — the script auto-detects which is available.

---

### Script 3 — Disk and Permission Auditor
Loops through a list of important Linux system directories and prints permissions, ownership, and disk usage for each. Also checks Linux Kernel-specific paths such as `/boot/grub`, `/sys/kernel`, `/proc/version`, and `/lib/modules/$(uname -r)`.

**Concepts used:** `for` loop, arrays, `ls -ld`, `du -sh`, `awk`, `cut`, `uname`, `[ -d ]` and `[ -e ]` file tests

**Run:**
```bash
chmod +x script3_disk_permission_auditor.sh
./script3_disk_permission_auditor.sh
```

> Note: Some paths like `/proc` may show `N/A` for size — this is expected as `/proc` is a virtual filesystem.

---

### Script 4 — Log File Analyzer
Reads a log file line by line using a `while read` loop, counts occurrences of a keyword (default: `error`), and prints a summary with the last 5 matching lines. Auto-detects a system log if no file is specified.

**Concepts used:** `while IFS= read -r`, `if-then` inside loop, counter variables, `$1` and `$2` arguments, arrays, do-while retry pattern, `grep -iq`

**Run:**
```bash
chmod +x script4_log_analyzer.sh

# Auto-detect log file, search for 'error'
./script4_log_analyzer.sh

# Specify log file and keyword
./script4_log_analyzer.sh /var/log/syslog warning
./script4_log_analyzer.sh /var/log/kern.log panic
```

**Kernel-relevant logs to try:**
- `/var/log/kern.log` — Debian/Ubuntu kernel messages
- `/var/log/messages` — RHEL/Fedora system messages
- `dmesg > /tmp/dmesg.log && ./script4_log_analyzer.sh /tmp/dmesg.log error`

---

### Script 5 — Open Source Manifesto Generator
Asks the user three interactive questions and generates a personalised open-source philosophy statement, saving it to a timestamped `.txt` file.

**Concepts used:** `read` (interactive input), string concatenation, writing to file with `>` and `>>`, `date` command, aliases concept (demonstrated via comment), input validation

**Run:**
```bash
chmod +x script5_manifesto_generator.sh
./script5_manifesto_generator.sh
```

You will be prompted for three answers. The manifesto is saved as `manifesto_<username>_<timestamp>.txt` in the current directory.

---

## Running All Scripts at Once

```bash
# Make all scripts executable
chmod +x script*.sh

# Run them in sequence
./script1_system_identity.sh
./script2_foss_inspector.sh git
./script3_disk_permission_auditor.sh
./script4_log_analyzer.sh
./script5_manifesto_generator.sh
```

---

## Linux Environment Setup

These scripts are designed to run on any Linux distribution. Tested environments:

- Ubuntu 20.04 / 22.04 LTS
- CentOS / RHEL 8+
- Fedora 36+
- Any VIT lab Linux system

**To run on a Linux VM (if on Windows/Mac):**
```bash
# Option 1: WSL2 (Windows)
wsl --install

# Option 2: VirtualBox with Ubuntu ISO
# Download from: https://ubuntu.com/download/desktop

# Option 3: Online Linux terminal
# https://www.onlinegdb.com/online_bash_shell
```

---

## Academic Integrity

All scripts were written as original work for the OSS NGMC Capstone Project. The report (submitted as PDF) is written entirely in the student's own words, based on research of primary sources including the Linux Kernel documentation, GPL v2 license text, and reference materials listed in the project brief.

---

## References

- Linux Kernel official site: https://www.kernel.org
- GPL v2 license text: https://www.gnu.org/licenses/old-licenses/gpl-2.0.html
- GNU Free Software Definition: https://gnu.org/philosophy/free-sw.html
- Linus Torvalds — *Just for Fun* (autobiography)
- The Linux Command Line — William Shotts: https://linuxcommand.org
- GNU Bash Manual: https://gnu.org/software/bash/manual
