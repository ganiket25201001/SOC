#!/usr/bin/env bash
set -euo pipefail

if [[ "${EUID}" -ne 0 ]]; then
  echo "Error: Run as root (sudo)."
  exit 1
fi

echo "Installing rsyslog if needed..."
apt-get update
apt-get install -y rsyslog

CONFIG_FILE="/etc/rsyslog.conf"

ensure_line_before_global_directives() {
  local line="$1"
  local tmp_file

  tmp_file="$(mktemp)"
  awk -v line="$line" '
    !inserted && /GLOBAL DIRECTIVES/ {
      print line
      inserted=1
    }
    { print }
    END {
      if (!inserted) {
        print line
      }
    }
  ' "$CONFIG_FILE" > "$tmp_file"
  cat "$tmp_file" > "$CONFIG_FILE"
  rm -f "$tmp_file"
}

echo "Updating $CONFIG_FILE for remote reception..."
sed -i 's/^[[:space:]]*#[[:space:]]*module(load="imudp")[[:space:]]*$/module(load="imudp")/' "$CONFIG_FILE"
sed -i 's/^[[:space:]]*#[[:space:]]*input(type="imudp" port="514")[[:space:]]*$/input(type="imudp" port="514")/' "$CONFIG_FILE"
sed -i 's/^[[:space:]]*#[[:space:]]*module(load="imtcp")[[:space:]]*$/module(load="imtcp")/' "$CONFIG_FILE"
sed -i 's/^[[:space:]]*#[[:space:]]*input(type="imtcp" port="514")[[:space:]]*$/input(type="imtcp" port="514")/' "$CONFIG_FILE"

if ! grep -Eq '^[[:space:]]*module\(load="imudp"\)[[:space:]]*$' "$CONFIG_FILE"; then
  ensure_line_before_global_directives 'module(load="imudp")'
fi

if ! grep -Eq '^[[:space:]]*input\(type="imudp" port="514"\)[[:space:]]*$' "$CONFIG_FILE"; then
  ensure_line_before_global_directives 'input(type="imudp" port="514")'
fi

if ! grep -Eq '^[[:space:]]*module\(load="imtcp"\)[[:space:]]*$' "$CONFIG_FILE"; then
  ensure_line_before_global_directives 'module(load="imtcp")'
fi

if ! grep -Eq '^[[:space:]]*input\(type="imtcp" port="514"\)[[:space:]]*$' "$CONFIG_FILE"; then
  ensure_line_before_global_directives 'input(type="imtcp" port="514")'
fi

if ! grep -Eq '^[[:space:]]*\$template[[:space:]]+remote-incoming-logs,"/var/log/%HOSTNAME%/%PROGRAMNAME%\.log"[[:space:]]*$' "$CONFIG_FILE"; then
  ensure_line_before_global_directives '$template remote-incoming-logs,"/var/log/%HOSTNAME%/%PROGRAMNAME%.log"'
fi

if ! grep -Eq '^[[:space:]]*\*\.\*[[:space:]]+\?remote-incoming-logs[[:space:]]*$' "$CONFIG_FILE"; then
  ensure_line_before_global_directives '*.* ?remote-incoming-logs'
fi

echo "Validating rsyslog config..."
rsyslogd -N1 -f /etc/rsyslog.conf

echo "Restarting and enabling rsyslog..."
systemctl restart rsyslog
systemctl enable rsyslog

echo "Opening firewall ports if ufw exists..."
if command -v ufw >/dev/null 2>&1; then
  ufw allow 514/tcp || true
  ufw allow 514/udp || true
else
  echo "ufw not found, skipping firewall step."
fi

echo "Checking listening ports..."
ss -tunelp | grep ':514' || true

echo "Practical 5 completed successfully."
