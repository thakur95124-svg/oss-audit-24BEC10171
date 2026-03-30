#!/bin/bash
# ============================================================
# Script 2: FOSS Package Inspector
# Author: [Thakur Shubham Kumar] | Registration: [24BEC10171]
# Course: Open Source Software | Capstone Project
# Purpose: Check if a FOSS package is installed and describe it
# ============================================================

# --- Define the package to inspect ---
PACKAGE="git"    # Our audited software

# --- Print header ---
echo "============================================"
echo "   FOSS Package Inspector"
echo "============================================"
echo "  Checking package: $PACKAGE"
echo "--------------------------------------------"

# --- Detect package manager and check if installed ---
# Use if-then-else to handle both RPM-based and Debian-based systems

if command -v rpm &>/dev/null; then
    # RPM-based system (RHEL, CentOS, Fedora)
    if rpm -q "$PACKAGE" &>/dev/null; then
        echo "  STATUS: $PACKAGE is INSTALLED (RPM system)"
        echo ""
        echo "  --- Package Details ---"
        # Use grep to filter only relevant fields from rpm -qi output
        rpm -qi "$PACKAGE" | grep -E "^(Name|Version|License|Summary|URL)"
    else
        echo "  STATUS: $PACKAGE is NOT installed on this system."
        echo "  To install, run: sudo dnf install $PACKAGE"
    fi

elif command -v dpkg &>/dev/null; then
    # Debian/Ubuntu-based system
    if dpkg -l "$PACKAGE" 2>/dev/null | grep -q "^ii"; then
        echo "  STATUS: $PACKAGE is INSTALLED (Debian system)"
        echo ""
        echo "  --- Package Details ---"
        # dpkg -l shows installed packages; grep for our package details
        dpkg -l "$PACKAGE" | grep "^ii" | awk '{print "  Package: "$2"\n  Version: "$3"\n  Arch: "$4}'
    else
        echo "  STATUS: $PACKAGE is NOT installed on this system."
        echo "  To install, run: sudo apt install $PACKAGE"
    fi

else
    
    if which "$PACKAGE" &>/dev/null; then
        echo "  STATUS: $PACKAGE binary found at: $(which $PACKAGE)"
        
        echo "  Version: $($PACKAGE --version 2>/dev/null)"
    else
        echo "  STATUS: Cannot determine — no known package manager found."
    fi
fi

echo ""


if command -v git &>/dev/null; then
    echo "  Git Version Installed: $(git --version)"
fi

echo ""
echo "--------------------------------------------"


echo "  OPEN SOURCE PHILOSOPHY NOTE:"
echo "--------------------------------------------"

case $PACKAGE in
    git)
        # Our audited software
        echo "  Git: Born from necessity when freedom was taken away."
        echo "  Linus Torvalds built Git in 2005 after BitKeeper revoked"
        echo "  its free license. Git embodies the OSS value: when a"
        echo "  proprietary tool fails you, build your own and share it."
        ;;
    httpd | apache2)
        echo "  Apache: the web server that built the open internet."
        echo "  Apache HTTP Server has powered the web since 1995 and"
        echo "  remains one of the most successful OSS projects ever."
        ;;
    mysql | mysql-server)
        echo "  MySQL: open source at the heart of millions of apps."
        echo "  MySQL uses a dual-license model: GPL for OSS projects"
        echo "  and a commercial license for proprietary use."
        ;;
    vlc | vlc-bin)
        echo "  VLC: built by students for students."
        echo "  VLC was created at a French university to stream video"
        echo "  over campus networks. Now it plays virtually everything."
        ;;
    firefox)
        echo "  Firefox: a nonprofit fighting for an open web."
        echo "  Mozilla's Firefox exists to ensure no single company"
        echo "  controls the internet's browser ecosystem."
        ;;
    python3 | python)
        echo "  Python: a language shaped entirely by community."
        echo "  Python's PSF license and governance model is one of"
        echo "  the best examples of community-driven development."
        ;;
    libreoffice)
        echo "  LibreOffice: born from a community fork."
        echo "  When Oracle acquired Sun, the community forked"
        echo "  OpenOffice to create LibreOffice — OSS self-governance."
        ;;
    *)
        # Default case for any other package
        echo "  $PACKAGE: An open-source tool that gives you the"
        echo "  freedom to run, study, modify, and share software."
        ;;
esac

echo ""
echo "============================================"
echo "  End of FOSS Package Inspector"
echo "============================================"
