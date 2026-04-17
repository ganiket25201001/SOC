#!/usr/bin/env bash
set -euo pipefail

if [[ "${EUID}" -ne 0 ]]; then
  echo "Error: Run as root (sudo)."
  exit 1
fi

echo "Installing rsyslog if needed..."
apt-get update
apt-get install -y rsyslog

CONFIG_FILE="/etc/rsyslog.d/90-soc-remote-server.conf"
cat > "$CONFIG_FILE" <<'EOF'
# SOC Practical 5: remote syslog server
module(load="imudp")
input(type="imudp" port="514")

module(load="imtcp")
input(type="imtcp" port="514")

$template remote-incoming-logs,"/var/log/%HOSTNAME%/%PROGRAMNAME%.log"
*.* ?remote-incoming-logs
EOF

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
