#!/bin/bash
# =============================================================================
# Script 4: Log File Analyzer
# Author   : Thakur Shubham Kumar
# Reg. No  : 24BEC10171
# Course   : Open Source Software (NGMC)
# Purpose  : Read a log file line by line, count occurrences of a keyword,
#            and print a summary. Supports command-line arguments.
# Usage    : ./script4_log_analyzer.sh [logfile] [keyword]
#            Example: ./script4_log_analyzer.sh /var/log/syslog error
#            Example: ./script4_log_analyzer.sh /var/log/kern.log warning
# =============================================================================

echo "============================================================"
echo "         LOG FILE ANALYZER"
echo "  Student : Thakur Shubham Kumar | Reg: 24BEC10171"
echo "  Audit Tool for Linux Kernel Logs"
echo "============================================================"
echo ""

# --- Accept command-line arguments ---
# $1 = log file path, $2 = keyword to search (default: 'error')
LOGFILE=$1
KEYWORD=${2:-"error"}   # Default keyword is 'error' if not provided

# --- If no log file given, auto-detect a common one ---
if [ -z "$LOGFILE" ]; then
    echo "  No log file specified. Auto-detecting..."
    # Try common log file locations in order
    for CANDIDATE in /var/log/kern.log /var/log/syslog /var/log/messages /var/log/dmesg; do
        if [ -f "$CANDIDATE" ]; then
            LOGFILE="$CANDIDATE"
            echo "  Using: $LOGFILE"
            break
        fi
    done

    # If still no file found, create a sample log for demonstration
    if [ -z "$LOGFILE" ]; then
        LOGFILE="/tmp/sample_kernel.log"
        echo "  No standard log found. Creating sample log at $LOGFILE"
        cat > "$LOGFILE" << 'EOF'
Jan 01 10:00:01 kernel: [    0.000000] Linux version 6.1.0 (gcc@build)
Jan 01 10:00:02 kernel: [    0.001000] BIOS-provided physical RAM map
Jan 01 10:00:03 kernel: [    1.234567] ERROR: Unable to load module foo
Jan 01 10:00:04 kernel: [    1.235000] WARNING: deprecated call in bar.c
Jan 01 10:00:05 kernel: [    2.100000] net eth0: Link is Up
Jan 01 10:00:06 kernel: [    2.500000] ERROR: ACPI table checksum failed
Jan 01 10:00:07 kernel: [    3.000000] systemd[1]: Started kernel daemon
Jan 01 10:00:08 kernel: [    3.500000] WARNING: possible circular locking
Jan 01 10:00:09 kernel: [    4.000000] ERROR: failed to initialise device
Jan 01 10:00:10 kernel: [    5.000000] Kernel alive and running normally
EOF
    fi
fi

# --- Validate the log file exists and is readable ---
if [ ! -f "$LOGFILE" ]; then
    echo "  ERROR: File '$LOGFILE' not found."
    echo "  Please provide a valid log file path as the first argument."
    exit 1
fi

# --- Check if the file is empty ---
# Simulated do-while retry pattern using a while loop + break
ATTEMPT=0
while true; do
    ATTEMPT=$((ATTEMPT + 1))

    if [ -s "$LOGFILE" ]; then
        # File is non-empty, proceed
        break
    else
        echo "  WARNING: Log file is empty (attempt $ATTEMPT)."
        if [ $ATTEMPT -ge 3 ]; then
            echo "  File remains empty after $ATTEMPT checks. Exiting."
            exit 1
        fi
        echo "  Waiting 1 second before retry..."
        sleep 1
    fi
done

# --- Count keyword occurrences using while-read loop ---
COUNT=0           # Counter variable for matches
LINE_NUM=0        # Track line number
MATCHED_LINES=()  # Array to store matched lines for later display

echo "  Log File  : $LOGFILE"
echo "  Keyword   : '$KEYWORD'"
echo "  Scanning..."
echo ""

# while-read loop: reads the log file line by line
while IFS= read -r LINE; do
    LINE_NUM=$((LINE_NUM + 1))

    # if-then: check if the line contains our keyword (case-insensitive with -i)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))
        # Store matched line with its line number in the array
        MATCHED_LINES+=("Line $LINE_NUM: $LINE")
    fi

done < "$LOGFILE"

# --- Display results summary ---
echo "------------------------------------------------------------"
echo "  SCAN RESULTS"
echo "------------------------------------------------------------"
echo "  Total lines scanned   : $LINE_NUM"
echo "  Keyword matches found : $COUNT"
echo "  Search keyword        : '$KEYWORD'"
echo ""

# --- Show the last 5 matching lines (tail-style) ---
if [ $COUNT -gt 0 ]; then
    echo "  Last 5 matching lines:"
    echo "  ............................................................"

    # Calculate starting index for last 5 (arrays are 0-indexed in bash)
    TOTAL=${#MATCHED_LINES[@]}
    START=$(( TOTAL > 5 ? TOTAL - 5 : 0 ))

    # Loop through last 5 matched lines and print them
    for (( i=START; i<TOTAL; i++ )); do
        echo "  ${MATCHED_LINES[$i]}" | cut -c1-80   # Trim long lines for readability
    done

    echo "  ............................................................"
    echo ""
    echo "  TIP: Run 'grep -in \"$KEYWORD\" $LOGFILE' for full grep output."
else
    echo "  No lines matched keyword '$KEYWORD' in $LOGFILE"
    echo "  Try a different keyword: error, warning, fail, panic, critical"
fi

echo ""
echo "  Kernel Log Context: The Linux Kernel logs to /var/log/kern.log"
echo "  (Debian) or via 'dmesg' on all systems. These logs reveal how"
echo "  the open-source kernel handles hardware, drivers, and errors."
echo "============================================================"
