#!/bin/bash
# =============================================================================
# Script 1: System Identity Report
# Author   : Thakur Shubham Kumar
# Reg. No  : 24BEC10171
# Course   : Open Source Software (NGMC)
# Purpose  : Display a welcome screen with key Linux system information
#            relevant to the Open Source Audit of the Linux Kernel.
# =============================================================================

# --- Student & Project Variables ---
STUDENT_NAME="Thakur Shubham Kumar"
REG_NO="24BEC10171"
SOFTWARE_CHOICE="Linux Kernel"
KERNEL_LICENSE="GNU General Public License v2 (GPL-2.0)"

# --- Gather System Information using command substitution $() ---
KERNEL_VERSION=$(uname -r)                          # Current running kernel version
DISTRO_NAME=$(grep PRETTY_NAME /etc/os-release 2>/dev/null | cut -d= -f2 | tr -d '"')
CURRENT_USER=$(whoami)                              # Logged-in username
HOME_DIR=$HOME                                      # Home directory of current user
UPTIME_INFO=$(uptime -p)                            # Human-readable uptime
CURRENT_DATETIME=$(date '+%A, %d %B %Y | %H:%M:%S') # Formatted date and time
HOSTNAME=$(hostname)                                # Machine hostname

# --- Display Header Banner ---
echo "============================================================"
echo "          OPEN SOURCE AUDIT — SYSTEM IDENTITY REPORT       "
echo "============================================================"
echo ""

# --- Student Information ---
echo "  Student  : $STUDENT_NAME"
echo "  Reg. No  : $REG_NO"
echo "  Software : $SOFTWARE_CHOICE"
echo ""
echo "------------------------------------------------------------"

# --- System Information Block ---
echo "  SYSTEM INFORMATION"
echo "------------------------------------------------------------"
echo "  Hostname     : $HOSTNAME"
echo "  Distribution : ${DISTRO_NAME:-Unknown (check /etc/os-release)}"
echo "  Kernel Ver.  : $KERNEL_VERSION"
echo "  Current User : $CURRENT_USER"
echo "  Home Dir     : $HOME_DIR"
echo "  System Uptime: $UPTIME_INFO"
echo "  Date & Time  : $CURRENT_DATETIME"
echo ""
echo "------------------------------------------------------------"

# --- License Information ---
echo "  OPEN SOURCE LICENSE"
echo "------------------------------------------------------------"
echo "  The Linux Kernel is licensed under:"
echo "  $KERNEL_LICENSE"
echo ""
echo "  This means you have the four essential freedoms:"
echo "    [0] Freedom to run the program for any purpose"
echo "    [1] Freedom to study and modify the source code"
echo "    [2] Freedom to redistribute copies"
echo "    [3] Freedom to distribute your modified versions"
echo ""
echo "============================================================"
echo "  'What nobody tells you about documentation: the only"
echo "   reader you're likely to get is the future you.'"
echo "                                    — Linus Torvalds"
echo "============================================================"
