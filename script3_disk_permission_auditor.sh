#!/bin/bash
# =============================================================================
# Script 3: Disk and Permission Auditor
# Author   : Thakur Shubham Kumar
# Reg. No  : 24BEC10171
# Course   : Open Source Software (NGMC)
# Purpose  : Loop through key Linux system directories, report their disk
#            usage, permissions, and ownership. Also checks Linux Kernel
#            config and source directories if present.
# =============================================================================

echo "============================================================"
echo "         DISK AND PERMISSION AUDITOR"
echo "  Student : Thakur Shubham Kumar | Reg: 24BEC10171"
echo "  Auditing key Linux Kernel directories"
echo "============================================================"
echo ""

# --- Array of important Linux system directories to audit ---
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/boot" "/proc" "/lib/modules")

echo "  Directory Audit Report"
echo "  ---------------------------------------------------------------"
printf "  %-20s %-25s %-10s\n" "DIRECTORY" "PERMISSIONS (perms owner group)" "SIZE"
echo "  ---------------------------------------------------------------"

# --- For loop to iterate over each directory ---
for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # Extract permissions, owner, group using awk on ls -ld output
        PERMS=$(ls -ld "$DIR" | awk '{print $1, $3, $4}')

        # Get directory size; suppress errors (e.g. /proc has virtual files)
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)
        SIZE="${SIZE:-N/A}"   # If du fails (like /proc), show N/A

        printf "  %-20s %-25s %-10s\n" "$DIR" "$PERMS" "$SIZE"
    else
        # Directory does not exist on this system
        printf "  %-20s %-25s\n" "$DIR" "[does not exist on this system]"
    fi
done

echo "  ---------------------------------------------------------------"
echo ""

# --- Special Section: Linux Kernel-specific config directory check ---
echo "------------------------------------------------------------"
echo "  LINUX KERNEL SPECIFIC DIRECTORY CHECK"
echo "------------------------------------------------------------"

# Array of kernel-specific paths to check
KERNEL_PATHS=(
    "/boot/grub"
    "/boot/grub2"
    "/etc/modules"
    "/etc/modprobe.d"
    "/proc/version"
    "/proc/cmdline"
    "/sys/kernel"
    "/lib/modules/$(uname -r)"
)

echo ""
echo "  Checking Linux Kernel-related paths:"
echo ""

for KPATH in "${KERNEL_PATHS[@]}"; do
    if [ -e "$KPATH" ]; then
        # Path exists — check if it's a file or directory
        if [ -d "$KPATH" ]; then
            KPERMS=$(ls -ld "$KPATH" | awk '{print $1, $3, $4}')
            echo "  [DIR]  $KPATH"
            echo "         Permissions: $KPERMS"
        else
            # It's a file — show its content briefly
            KPERMS=$(ls -l "$KPATH" | awk '{print $1, $3, $4}')
            CONTENT=$(cat "$KPATH" 2>/dev/null | head -1 | cut -c1-60)
            echo "  [FILE] $KPATH"
            echo "         Permissions : $KPERMS"
            echo "         Content     : $CONTENT"
        fi
        echo ""
    else
        echo "  [N/A]  $KPATH — not found on this system"
        echo ""
    fi
done

# --- Display current kernel version as confirmation ---
echo "------------------------------------------------------------"
echo "  Running Kernel   : $(uname -r)"
echo "  Kernel Arch      : $(uname -m)"
echo "  OS Type          : $(uname -o)"
echo "------------------------------------------------------------"
echo ""
echo "  Security Note: Directory permissions matter. /tmp is world-writable"
echo "  (rwxrwxrwt) — the sticky bit (t) prevents users from deleting"
echo "  each other's files. This is open-source security by design."
echo "============================================================"
