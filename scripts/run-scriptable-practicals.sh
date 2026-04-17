#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

declare -A SCRIPTS=(
  [1]="practical-01-openssl.sh"
  [5]="practical-05-rsyslog-server.sh"
  [7]="practical-07-install-splunk.sh"
  [8]="practical-08-install-elk.sh"
  [9]="practical-09-install-graylog.sh"
  [10]="practical-10-normalize-logs.sh"
)

print_usage() {
  cat <<'EOF'
Usage:
  ./scripts/run-scriptable-practicals.sh --list
  ./scripts/run-scriptable-practicals.sh --number <1|5|7|8|9|10>
  ./scripts/run-scriptable-practicals.sh --all

Notes:
- Practicals 2, 3, 4, and 6 are skipped because they are not fully automatable end-to-end.
- Some scripts require environment variables (OPENSSL_PASS, SPLUNK_ADMIN_PASSWORD, GRAYLOG_ADMIN_PASSWORD).
EOF
}

run_script() {
  local number="$1"
  local script_name="${SCRIPTS[$number]}"
  local script_path="$SCRIPT_DIR/$script_name"

  if [[ ! -f "$script_path" ]]; then
    echo "Script not found: $script_path" >&2
    return 1
  fi

  chmod +x "$script_path"
  echo
  echo "==== Running Practical $number ($script_name) ===="
  "$script_path"
}

MODE=""
NUMBER=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    -l|--list)
      MODE="list"
      ;;
    -n|--number)
      shift
      NUMBER="${1:-}"
      MODE="number"
      ;;
    -a|--all)
      MODE="all"
      ;;
    -h|--help)
      print_usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      print_usage
      exit 1
      ;;
  esac
  shift
done

if [[ -z "$MODE" ]]; then
  MODE="list"
fi

if [[ "$MODE" == "list" ]]; then
  echo "Scriptable practicals:"
  for n in 1 5 7 8 9 10; do
    echo "  $n -> scripts/${SCRIPTS[$n]}"
  done
  echo
  echo "Skipped (not fully automatable): 2, 3, 4, 6"
  exit 0
fi

if [[ "$MODE" == "number" ]]; then
  if [[ -z "$NUMBER" || -z "${SCRIPTS[$NUMBER]+x}" ]]; then
    echo "Invalid practical number. Allowed: 1, 5, 7, 8, 9, 10" >&2
    exit 1
  fi
  run_script "$NUMBER"
  exit 0
fi

if [[ "$MODE" == "all" ]]; then
  for n in 1 5 7 8 9 10; do
    run_script "$n"
  done
  exit 0
fi
