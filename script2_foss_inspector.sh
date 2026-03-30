#!/bin/bash
# =============================================================================
# Script 2: FOSS Package Inspector
# Author   : Thakur Shubham Kumar
# Reg. No  : 24BEC10171
# Course   : Open Source Software (NGMC)
# Purpose  : Check if a FOSS package is installed, display its version/license,
#            and print a philosophy note using a case statement.
# Usage    : ./script2_foss_inspector.sh [package_name]
#            If no argument given, defaults to checking kernel-related tools.
# =============================================================================

# --- Accept optional package name as argument, or use default ---
PACKAGE=${1:-"bash"}   # Default to 'bash' if no argument provided

echo "============================================================"
echo "         FOSS PACKAGE INSPECTOR"
echo "  Student : Thakur Shubham Kumar | Reg: 24BEC10171"
echo "============================================================"
echo ""
echo "  Inspecting package: '$PACKAGE'"
echo "------------------------------------------------------------"

# --- Check if package is installed using if-then-else ---
# Try rpm first (RHEL/Fedora/VIT lab systems), then dpkg (Debian/Ubuntu)

INSTALLED=false

if command -v rpm &>/dev/null; then
    # RPM-based system (CentOS, RHEL, Fedora)
    if rpm -q "$PACKAGE" &>/dev/null; then
        INSTALLED=true
        echo "  [FOUND] '$PACKAGE' is installed on this system (RPM)."
        echo ""
        echo "  --- Package Details ---"
        rpm -qi "$PACKAGE" 2>/dev/null | grep -E "^(Name|Version|License|Summary|URL)" \
            | awk -F': ' '{printf "  %-10s: %s\n", $1, $2}'
    fi
elif command -v dpkg &>/dev/null; then
    # Debian/Ubuntu-based system
    if dpkg -l "$PACKAGE" 2>/dev/null | grep -q "^ii"; then
        INSTALLED=true
        echo "  [FOUND] '$PACKAGE' is installed on this system (dpkg)."
        echo ""
        echo "  --- Package Details ---"
        dpkg -s "$PACKAGE" 2>/dev/null | grep -E "^(Package|Version|Maintainer|Description)" \
            | awk -F': ' '{printf "  %-12s: %s\n", $1, $2}'
    fi
fi

# --- If not found via package manager, check if the binary exists ---
if [ "$INSTALLED" = false ]; then
    if command -v "$PACKAGE" &>/dev/null; then
        echo "  [FOUND] '$PACKAGE' is available as a binary (may not be a managed package)."
        echo "  Binary location: $(which $PACKAGE)"
        INSTALLED=true
    else
        echo "  [NOT FOUND] '$PACKAGE' does not appear to be installed."
        echo "  Tip: Install it with 'sudo apt install $PACKAGE' or 'sudo dnf install $PACKAGE'"
    fi
fi

echo ""
echo "------------------------------------------------------------"
echo "  OPEN SOURCE PHILOSOPHY NOTE"
echo "------------------------------------------------------------"

# --- Case statement: print a philosophy note for known FOSS packages ---
case "$PACKAGE" in
    linux-kernel | kernel | uname)
        echo "  Linux Kernel (GPL v2): Born from Linus Torvalds' frustration"
        echo "  with proprietary Unix. GPL ensures every improvement stays free."
        ;;
    bash | sh)
        echo "  GNU Bash (GPL v3): The shell that powers millions of scripts."
        echo "  Part of GNU — Richard Stallman's vision of a fully free OS."
        ;;
    git)
        echo "  Git (GPL v2): Built by Linus Torvalds in 2 weeks when the"
        echo "  proprietary BitKeeper revoked Linux's free license. Open source"
        echo "  creates resilience against corporate control."
        ;;
    httpd | apache2)
        echo "  Apache HTTP Server (Apache 2.0): Powers ~30% of the web."
        echo "  The Apache license allows commercial use without copyleft —"
        echo "  a different philosophy from GPL but equally valid."
        ;;
    python3 | python)
        echo "  Python (PSF License): A language shaped entirely by community."
        echo "  Guido van Rossum stepped back; the community took over. Proof"
        echo "  that open source governance scales beyond one person."
        ;;
    mysql | mariadb)
        echo "  MySQL/MariaDB (GPL v2 / Commercial): A tale of two licenses."
        echo "  When Oracle acquired MySQL, the community forked it into MariaDB."
        echo "  Open source gives users an exit when corporate interests diverge."
        ;;
    firefox)
        echo "  Firefox (MPL 2.0): A nonprofit browser fighting for an open web."
        echo "  Mozilla exists to prove that mission-driven software can compete"
        echo "  against trillion-dollar corporations."
        ;;
    vlc)
        echo "  VLC (LGPL/GPL): Built by students in Paris who just wanted to"
        echo "  watch videos on their university network. Community > commercial."
        ;;
    gcc | g++)
        echo "  GCC (GPL v3): The compiler that compiles the Linux Kernel itself."
        echo "  Without free compilers, free software cannot exist. The toolchain"
        echo "  is the foundation of the entire FOSS ecosystem."
        ;;
    *)
        echo "  '$PACKAGE' is part of the vast open-source ecosystem."
        echo "  Every FOSS tool represents a choice: knowledge shared freely"
        echo "  is knowledge that compounds — for everyone, forever."
        ;;
esac

echo ""
echo "============================================================"
