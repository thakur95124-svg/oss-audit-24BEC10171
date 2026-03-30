#!/bin/bash
# ============================================================
# Script 4: Log File Analyzer
# Author: [Thakur Shubham Kumar] | Registration: [24BEC10171]
# Course: Open Source Software | Capstone Project
# Usage: ./script4_log_analyzer.sh /var/log/syslog [keyword]
# Usage: ./script4_log_analyzer.sh /var/log/messages [keyword]
# ============================================================

# --- Accept log file path as first command-line argument ---
LOGFILE=$1

# --- Accept keyword as second argument; default to 'error' if not provided ---
KEYWORD=${2:-"error"}

# --- Counters for tracking matches ---
COUNT=0           # Total keyword matches
LINE_NUM=0        # Track current line number

# --- Print header ---
echo "============================================"
echo "   Log File Analyzer — OSS Capstone"
echo "============================================"
echo "  Log File : $LOGFILE"
echo "  Keyword  : $KEYWORD"
echo "--------------------------------------------"

# --- Validate: check if a file argument was provided ---
if [ -z "$LOGFILE" ]; then
    echo "  ERROR: No log file specified."
    echo "  Usage: $0 /path/to/logfile [keyword]"
    echo "  Example: $0 /var/log/syslog error"
    exit 1
fi

# --- Validate: check if log file actually exists ---
if [ ! -f "$LOGFILE" ]; then
    echo "  ERROR: File '$LOGFILE' not found."
    echo ""

    # --- Retry logic: suggest common log file locations ---
    echo "  Trying common log locations..."
    RETRY_COUNT=0   # Counter for do-while style retry loop

    # Simulated do-while: try up to 3 alternative log files
    for ALT_LOG in "/var/log/syslog" "/var/log/messages" "/var/log/kern.log"; do
        RETRY_COUNT=$((RETRY_COUNT + 1))
        echo "  Attempt $RETRY_COUNT: Checking $ALT_LOG..."

        if [ -f "$ALT_LOG" ]; then
            echo "  Found alternative log: $ALT_LOG"
            echo "  Switching to: $ALT_LOG"
            LOGFILE="$ALT_LOG"   # Use this alternative file
            break                # Exit the retry loop
        fi

        # Stop after 3 attempts
        if [ $RETRY_COUNT -ge 3 ]; then
            echo "  No standard log files found after $RETRY_COUNT attempts."
            echo "  Please provide a valid log file path."
            exit 1
        fi
    done
fi

# --- Check if file is empty ---
if [ ! -s "$LOGFILE" ]; then
    echo "  WARNING: Log file exists but is empty."
    echo "  Nothing to analyze."
    exit 0
fi

echo "  Scanning log file for keyword: '$KEYWORD'..."
echo ""

# --- Read the log file line by line using a while-read loop ---
while IFS= read -r LINE; do
    LINE_NUM=$((LINE_NUM + 1))   # Increment line counter

    # Use if-then inside the while loop to check each line for the keyword
    # -i flag makes grep case-insensitive
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))     # Increment match counter
    fi

done < "$LOGFILE"    # Feed the log file into the while loop via input redirection

# --- Print summary ---
echo "--------------------------------------------"
echo "  SUMMARY"
echo "--------------------------------------------"
echo "  Total lines scanned : $LINE_NUM"
echo "  Keyword matches     : $COUNT"
echo "  Keyword searched    : '$KEYWORD'"
echo ""

# --- Show last 5 matching lines using grep and tail ---
if [ $COUNT -gt 0 ]; then
    echo "  Last 5 matching lines:"
    echo "  ................................"
    # grep -i: case-insensitive | tail -5: last 5 results
    grep -i "$KEYWORD" "$LOGFILE" | tail -5 | while IFS= read -r MATCH_LINE; do
        # Indent each matching line for readability
        echo "    >> $MATCH_LINE"
    done
else
    echo "  No lines containing '$KEYWORD' were found in $LOGFILE."
fi

echo ""
echo "============================================"
echo "  End of Log File Analyzer"
echo "============================================"
