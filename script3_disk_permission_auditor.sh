#!/bin/bash
# ============================================================
# Script 3: Disk and Permission Auditor
# Author: [Thakur Shubham Kumar] | Registration: [24BEC10171]
# Course: Open Source Software | Capstone Project
# Purpose: Audit key Linux directories for permissions and size
# ============================================================


DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/share" "/var")


GIT_DIRS=("/etc/gitconfig" "/usr/share/git-core" "/usr/lib/git-core")

# --- Print report header ---
echo "================================================================"
echo "         DISK AND PERMISSION AUDITOR — OSS Capstone             "
echo "================================================================"
echo "  Auditing standard Linux system directories..."
echo ""
printf "  %-20s %-12s %-30s\n" "Directory" "Size" "Permissions  Owner  Group"
echo "  --------------------------------------------------------------------"

# --- Loop through each directory using a for loop ---
for DIR in "${DIRS[@]}"; do

    # Check if directory exists before trying to read it
    if [ -d "$DIR" ]; then
        # Get permissions, owner, and group using ls -ld, then extract fields with awk
        PERMS=$(ls -ld "$DIR" | awk '{print $1}')
        OWNER=$(ls -ld "$DIR" | awk '{print $3}')     
        GROUP=$(ls -ld "$DIR" | awk '{print $4}')     

        # Get directory size; redirect stderr to suppress permission denied errors
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        # Print formatted output
        printf "  %-20s %-12s %s  %s  %s\n" "$DIR" "$SIZE" "$PERMS" "$OWNER" "$GROUP"
    else
        # Directory does not exist on this system
        printf "  %-20s %-12s %s\n" "$DIR" "N/A" "[does not exist]"
    fi

done

echo ""
echo "================================================================"
echo "  GIT-SPECIFIC DIRECTORY AUDIT"
echo "================================================================"
echo "  Checking Git's configuration and core directories..."
echo ""

# --- Check Git-specific directories and files ---
for GDIR in "${GIT_DIRS[@]}"; do
    if [ -e "$GDIR" ]; then
        # -e checks existence for both files and directories
        PERMS=$(ls -ld "$GDIR" | awk '{print $1}')
        OWNER=$(ls -ld "$GDIR" | awk '{print $3}')
        GROUP=$(ls -ld "$GDIR" | awk '{print $4}')
        SIZE=$(du -sh "$GDIR" 2>/dev/null | cut -f1)
        printf "  %-30s %-10s %s  %s  %s\n" "$GDIR" "$SIZE" "$PERMS" "$OWNER" "$GROUP"
    else
        printf "  %-30s %s\n" "$GDIR" "[not found on this system]"
    fi
done

echo ""

# --- Check user-level Git config ---
echo "  Checking user-level Git configuration..."
if [ -f "$HOME/.gitconfig" ]; then
    echo "  Found: $HOME/.gitconfig"
    PERMS=$(ls -l "$HOME/.gitconfig" | awk '{print $1}')
    echo "  Permissions: $PERMS (readable only by owner — good for security)"
else
    echo "  $HOME/.gitconfig — not found (Git not configured for this user yet)"
fi

echo ""

# --- Git binary location ---
echo "================================================================"
echo "  GIT BINARY INFORMATION"
echo "================================================================"

if command -v git &>/dev/null; then
    GIT_PATH=$(which git)                            
    GIT_VERSION=$(git --version)                     
    GIT_PERMS=$(ls -l "$GIT_PATH" | awk '{print $1, $3, $4}')

    echo "  Binary Path : $GIT_PATH"
    echo "  Version     : $GIT_VERSION"
    echo "  Permissions : $GIT_PERMS"
    echo ""
    echo "  Note: Git's binary in /usr/bin is owned by root and is"
    echo "  world-executable — any user on the system can run Git."
    echo "  This is by design for a collaboration tool."
else
    echo "  Git is not installed on this system."
    echo "  Install with: sudo apt install git (Debian/Ubuntu)"
    echo "              or sudo dnf install git (RHEL/Fedora)"
fi

echo ""
echo "================================================================"
echo "  End of Disk and Permission Auditor"
echo "================================================================"
