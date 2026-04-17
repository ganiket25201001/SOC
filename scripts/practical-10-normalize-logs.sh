#!/usr/bin/env bash
set -euo pipefail

LAB_DIR="${LAB_DIR:-/home/analyst/lab.support.files}"
APP_LOG="applicationX_in_epoch.log"
APP_HUMAN_LOG="applicationX_in_human.log"
APACHE_LOG="apache_in_epoch.log"
APACHE_HUMAN_LOG="apache_in_human.log"

if [[ ! -d "$LAB_DIR" ]]; then
  echo "Error: Lab directory not found: $LAB_DIR"
  exit 1
fi

cd "$LAB_DIR"

if [[ ! -f "$APP_LOG" ]]; then
  echo "Error: Missing $APP_LOG in $LAB_DIR"
  exit 1
fi

if [[ ! -f "$APACHE_LOG" ]]; then
  echo "Error: Missing $APACHE_LOG in $LAB_DIR"
  exit 1
fi

echo "Normalizing application log timestamps..."
awk 'BEGIN {FS=OFS="|"} {$3=strftime("%c",$3)} {print}' "$APP_LOG" > "$APP_HUMAN_LOG"

echo
echo "Application log (human-readable):"
cat "$APP_HUMAN_LOG"

echo
echo "Original Apache epoch log:"
cat "$APACHE_LOG"

echo
echo "Initial Apache conversion (for comparison):"
awk 'BEGIN {FS=OFS=" "} {$4=strftime("%c",$4)} {print}' "$APACHE_LOG"

echo
echo "Fixed Apache conversion (remove square brackets first):"
awk 'BEGIN {FS=OFS=" "} {gsub(/\[/,"",$4); gsub(/\]/,"",$4); $4=strftime("%c",$4)} {print}' "$APACHE_LOG" > "$APACHE_HUMAN_LOG"

cat "$APACHE_HUMAN_LOG"

echo
echo "Practical 10 completed successfully."
