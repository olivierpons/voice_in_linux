#!/bin/bash
# launch.sh — Start opons-voxd with rotating logs.
# Keeps opons_voxd.log (current) + opons_voxd.log.old (previous).
# Rotates when the current log exceeds 5 MB.

cd /home/olivier/opons-voxd

LOG="opons_voxd.log"
MAX_BYTES=5242880  # 5 MB

if [ -f "$LOG" ] && [ "$(stat -c%s "$LOG" 2>/dev/null)" -gt "$MAX_BYTES" ]; then
    mv -f "$LOG" "${LOG}.old"
fi

echo "=== opons-voxd started at $(date) ===" >> "$LOG"
export OPONS_VOXD_COMMANDS=1
exec ./opons-voxd 2>>"$LOG"
