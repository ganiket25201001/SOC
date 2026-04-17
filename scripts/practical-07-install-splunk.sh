#!/usr/bin/env bash
set -euo pipefail

if [[ "${EUID}" -ne 0 ]]; then
  echo "Error: Run as root (sudo)."
  exit 1
fi

SPLUNK_DEB_URL="${SPLUNK_DEB_URL:-https://download.splunk.com/products/splunk/releases/7.1.1/linux/splunk-7.1.1-8f0ead9ec3db-linux-2.6-amd64.deb}"
SPLUNK_DEB_PATH="/tmp/splunk.deb"

if [[ -z "${SPLUNK_ADMIN_PASSWORD:-}" ]]; then
  echo "Error: SPLUNK_ADMIN_PASSWORD is not set."
  echo "Example: sudo SPLUNK_ADMIN_PASSWORD='StrongPass!234' ./scripts/practical-07-install-splunk.sh"
  exit 1
fi

echo "Installing dependencies..."
apt-get update
apt-get install -y wget

echo "Downloading Splunk package..."
wget -O "$SPLUNK_DEB_PATH" "$SPLUNK_DEB_URL"

echo "Installing Splunk..."
dpkg -i "$SPLUNK_DEB_PATH" || apt-get install -f -y

if [[ ! -x "/opt/splunk/bin/splunk" ]]; then
  echo "Error: Splunk binary not found at /opt/splunk/bin/splunk"
  exit 1
fi

echo "Enabling Splunk boot-start and setting admin password..."
/opt/splunk/bin/splunk enable boot-start --accept-license --answer-yes --no-prompt --seed-passwd "$SPLUNK_ADMIN_PASSWORD"

echo "Starting Splunk service..."
service splunk restart || service splunk start

echo "Checking Splunk service status..."
service splunk status || true

echo "Splunk URL: http://localhost:8000/"
echo "Practical 7 completed successfully."
