#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

declare -A PRACTICALS=(
  [1]="practicals/practical-01-openssl.md"
  [2]="practicals/practical-02-snort-firewall.md"
  [3]="practicals/practical-03-extract-exe-from-pcap.md"
  [4]="practicals/practical-04-dns-traffic-analysis.md"
  [5]="practicals/practical-05-rsyslog-server.md"
  [6]="practicals/practical-06-forward-logs-to-syslog.md"
  [7]="practicals/practical-07-install-splunk-linux.md"
  [8]="practicals/practical-08-install-elk-linux.md"
  [9]="practicals/practical-09-install-graylog-linux.md"
  [10]="practicals/practical-10-convert-data-universal-format.md"
)

OPEN_MODE=false
LIST_MODE=false
ALL_MODE=false
NUMBER=""

print_usage() {
  cat <<'EOF'
Usage:
  ./run-practical.sh --list
  ./run-practical.sh --number <1-10>
  ./run-practical.sh --all
  ./run-practical.sh --number <1-10> --open
  ./run-practical.sh --all --open

Options:
  -l, --list      List all practical files
  -n, --number    Show a single practical file (1-10)
  -a, --all       Show all practical files
  -o, --open      Open file(s) in default app (Linux: xdg-open)
  -h, --help      Show this help message
EOF
}

show_file() {
  local relative_path="$1"
  local full_path="$SCRIPT_DIR/$relative_path"

  if [[ ! -f "$full_path" ]]; then
    echo "File not found: $full_path" >&2
    return 1
  fi

  printf "\n==== %s ====\n" "$relative_path"

  if [[ "$OPEN_MODE" == true ]]; then
    if command -v xdg-open >/dev/null 2>&1; then
      xdg-open "$full_path" >/dev/null 2>&1 &
    elif command -v open >/dev/null 2>&1; then
      open "$full_path"
    else
      echo "Open mode requested, but no opener found (xdg-open/open)." >&2
      return 1
    fi
  else
    cat "$full_path"
  fi
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -l|--list)
      LIST_MODE=true
      ;;
    -n|--number)
      shift
      if [[ $# -eq 0 ]]; then
        echo "Missing value for --number" >&2
        print_usage
        exit 1
      fi
      NUMBER="$1"
      ;;
    -a|--all)
      ALL_MODE=true
      ;;
    -o|--open)
      OPEN_MODE=true
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

if [[ "$ALL_MODE" == true && -n "$NUMBER" ]]; then
  echo "Use either --all or --number, not both." >&2
  exit 1
fi

if [[ "$LIST_MODE" == true || ("$ALL_MODE" == false && -z "$NUMBER") ]]; then
  echo "Available Practicals:"
  for i in {1..10}; do
    printf "%2d: %s\n" "$i" "${PRACTICALS[$i]}"
  done
  echo
  echo "Use --number <1-10>, --all, and optional --open"
  exit 0
fi

if [[ "$ALL_MODE" == true ]]; then
  for i in {1..10}; do
    show_file "${PRACTICALS[$i]}"
  done
  exit 0
fi

if [[ -n "$NUMBER" ]]; then
  if ! [[ "$NUMBER" =~ ^[0-9]+$ ]]; then
    echo "Invalid practical number: $NUMBER. Use values 1 to 10." >&2
    exit 1
  fi

  if [[ -z "${PRACTICALS[$NUMBER]+x}" ]]; then
    echo "Invalid practical number: $NUMBER. Use values 1 to 10." >&2
    exit 1
  fi

  show_file "${PRACTICALS[$NUMBER]}"
  exit 0
fi
