# OSS Capstone Audit — Git (Version Control System)

> Capstone audit of Git (GPL v2) for the VITyarthi Open Source Software course. Includes a 14-page project report covering origin story, license analysis, Linux footprint, and FOSS ecosystem, along with 5 bash shell scripts demonstrating practical Linux skills.

**Student Name:** [Thakur Shubham Kumar]  
**Registration Number:** [24BEC10171]  
**Course:** Open Source Software (NGMC) — VITyarthi  
**Software Audited:** Git — Distributed Version Control System  
**License of Audited Software:** GNU General Public License v2 (GPL v2)  

---

## About This Project

This repository is the technical submission for the **Open Source Audit** capstone project.
It contains five shell scripts that demonstrate practical Linux command-line skills, each tied
to the philosophy and structure of open-source software as covered in Units 1–5 of the course.

The software chosen for audit is **Git** — created by Linus Torvalds in 2005 after BitKeeper
revoked its free-of-charge license from the Linux kernel development community. Git is licensed
under GPL v2, has over 100 million users, and is arguably the most important piece of
open-source infrastructure in modern software development.

---

## Repository Structure

```
oss-audit-[rollnumber]/
│
├── README.md                          ← This file
├── script1_system_identity.sh         ← Script 1: System Identity Report
├── script2_package_inspector.sh       ← Script 2: FOSS Package Inspector
├── script3_disk_permission_auditor.sh ← Script 3: Disk and Permission Auditor
├── script4_log_analyzer.sh            ← Script 4: Log File Analyzer
└── script5_manifesto_generator.sh     ← Script 5: Open Source Manifesto Generator
```

---

## Script Descriptions

### Script 1 — System Identity Report (`script1_system_identity.sh`)
Displays a formatted system welcome screen showing:
- Linux distribution name and kernel version
- Current logged-in user and their home directory
- System uptime and current date/time
- The open-source license covering the OS (GPL v2 for the Linux kernel)

**Concepts:** variables, command substitution `$()`, `echo`, `date`, `uname`, `whoami`, `uptime`

---

### Script 2 — FOSS Package Inspector (`script2_package_inspector.sh`)
Checks whether Git is installed on the system, detects the package manager (RPM or Debian),
prints package version and license details, and uses a `case` statement to display
an open-source philosophy note for several well-known FOSS packages.

**Concepts:** `if-then-else`, `case` statement, `command -v`, `rpm -qi`, `dpkg -l`,
pipe `|` with `grep`

---

### Script 3 — Disk and Permission Auditor (`script3_disk_permission_auditor.sh`)
Loops through standard Linux directories (`/etc`, `/var/log`, `/home`, `/usr/bin`, `/tmp`)
and Git-specific paths, reporting the size, permissions, owner, and group of each.
Also locates and reports on the Git binary.

**Concepts:** `for` loop over a bash array, `if [ -d ]`, `ls -ld`, `awk`, `du -sh`, `cut`

---

### Script 4 — Log File Analyzer (`script4_log_analyzer.sh`)
Accepts a log file path and optional keyword as command-line arguments. Reads the file
line by line counting keyword matches, implements retry logic to find alternative log files,
and prints the last 5 matching lines.

**Concepts:** `while IFS= read -r` loop, `if-then` inside loop, counter variables,
`$1`/`$2` arguments, `${var:-default}`, `grep -i`, `tail`, retry loop

---

### Script 5 — Open Source Manifesto Generator (`script5_manifesto_generator.sh`)
Interactively asks three questions, generates a personalised open-source philosophy
statement, saves it to a `.txt` file, and displays it.

**Concepts:** `read -p`, input validation with `while [ -z ]`, string concatenation,
`>` and `>>` file output, `date`, `cat`, alias concept (demonstrated via comment)

---

## How to Run Each Script on Linux

### Prerequisites
- A Linux system (Ubuntu, Debian, Fedora, RHEL, Arch, or any mainstream distro)
- Bash shell (default on all Linux systems; verify with `bash --version`)
- Git installed: `sudo apt install git` (Debian/Ubuntu) or `sudo dnf install git` (Fedora/RHEL)

### Step-by-Step Instructions

**1. Clone this repository**
```bash
git clone https://github.com/[your-username]/oss-audit-[rollnumber].git
cd oss-audit-[rollnumber]
```

**2. Make all scripts executable**
```bash
chmod +x script1_system_identity.sh
chmod +x script2_package_inspector.sh
chmod +x script3_disk_permission_auditor.sh
chmod +x script4_log_analyzer.sh
chmod +x script5_manifesto_generator.sh
```

**3. Run Script 1 — System Identity Report**
```bash
./script1_system_identity.sh
```
No arguments required. Displays system identity and OS license information.

**4. Run Script 2 — FOSS Package Inspector**
```bash
./script2_package_inspector.sh
```
No arguments required. Checks for Git installation and prints package details.

**5. Run Script 3 — Disk and Permission Auditor**
```bash
./script3_disk_permission_auditor.sh
```
No arguments required. Audits system directories and Git-specific paths.

**6. Run Script 4 — Log File Analyzer**
```bash
# Basic usage with default keyword 'error'
./script4_log_analyzer.sh /var/log/syslog

# With a custom keyword
./script4_log_analyzer.sh /var/log/syslog warning

# On RHEL/CentOS systems use /var/log/messages
./script4_log_analyzer.sh /var/log/messages error
```
Requires a valid log file path as the first argument. Second argument (keyword) is optional.

**7. Run Script 5 — Open Source Manifesto Generator**
```bash
./script5_manifesto_generator.sh
```
No arguments required. Interactive — you will be prompted to answer three questions.
Your manifesto is saved to `manifesto_[yourusername].txt` in the current directory.

---

## Dependencies

| Script | Dependencies |
|--------|-------------|
| Script 1 | `uname`, `whoami`, `uptime`, `date`, `lsb_release` (all standard) |
| Script 2 | `rpm` (RPM systems) or `dpkg` (Debian systems), `git` |
| Script 3 | `ls`, `du`, `awk`, `cut`, `which` (all standard) |
| Script 4 | `grep`, `tail` (all standard) |
| Script 5 | `date`, `cat`, `whoami` (all standard) |

All dependencies are standard Linux utilities present on any mainstream distribution.
No additional software needs to be installed beyond what is already on your system.

---

## About the Audited Software — Git

| Property | Detail |
|----------|--------|
| **Full Name** | Git |
| **Category** | Distributed Version Control System |
| **License** | GNU General Public License v2 (GPL v2) |
| **Created by** | Linus Torvalds |
| **Created in** | April 2005 |
| **Current Maintainer** | Junio C Hamano |
| **Official Site** | https://git-scm.com |
| **Source Code** | https://github.com/git/git |
| **Mailing List** | git@vger.kernel.org |

---

## Academic Integrity

All written sections of the accompanying project report are the original work of the student
named above. Shell scripts are written and understood by the student. This repository
is submitted as part of the VITyarthi Open Source Software capstone project.

---

*"Every tool you will use in your career was shaped by people who chose to build in the open and share their work freely."*  
— VITyarthi OSS Course
