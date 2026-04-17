#!/usr/bin/env bash
set -euo pipefail

if [[ "${EUID}" -ne 0 ]]; then
  echo "Error: Run as root (sudo)."
  exit 1
fi

if [[ -z "${GRAYLOG_ADMIN_PASSWORD:-}" ]]; then
  echo "Error: GRAYLOG_ADMIN_PASSWORD is not set."
  echo "Example: sudo GRAYLOG_ADMIN_PASSWORD='StrongPass!234' ./scripts/practical-09-install-graylog.sh"
  exit 1
fi

GRAYLOG_REPO_URL="${GRAYLOG_REPO_URL:-https://packages.graylog2.org/repo/packages/graylog-4.2-repository_latest.deb}"
GRAYLOG_REPO_DEB="/tmp/graylog-repo.deb"
GRAYLOG_CONF="/etc/graylog/server/server.conf"
ES_YML="/etc/elasticsearch/elasticsearch.yml"
GRAYLOG_HTTP_BIND_ADDRESS="${GRAYLOG_HTTP_BIND_ADDRESS:-0.0.0.0:9000}"
GRAYLOG_HTTP_EXTERNAL_URI="${GRAYLOG_HTTP_EXTERNAL_URI:-http://127.0.0.1:9000/}"
TAIL_LOGS="${TAIL_LOGS:-false}"

echo "Installing prerequisites..."
apt-get update
apt-get install -y curl wget gnupg pwgen

echo "Installing MongoDB (distribution dependent)..."
if ! apt-get install -y mongodb-server; then
  echo "mongodb-server package unavailable, trying mongodb package..."
  apt-get install -y mongodb || true
fi

if systemctl list-unit-files | grep -q '^mongodb\.service'; then
  systemctl start mongodb || true
  systemctl enable mongodb || true
elif systemctl list-unit-files | grep -q '^mongod\.service'; then
  systemctl start mongod || true
  systemctl enable mongod || true
else
  echo "MongoDB service name not found. Continue with caution."
fi

if [[ -f "$ES_YML" ]]; then
  if grep -Eq '^[#[:space:]]*cluster\.name:' "$ES_YML"; then
    sed -i -E 's|^[#[:space:]]*cluster\.name:.*|cluster.name: graylog|' "$ES_YML"
  else
    echo 'cluster.name: graylog' >> "$ES_YML"
  fi

  if grep -Eq '^[#[:space:]]*action\.auto_create_index:' "$ES_YML"; then
    sed -i -E 's|^[#[:space:]]*action\.auto_create_index:.*|action.auto_create_index: false|' "$ES_YML"
  else
    echo 'action.auto_create_index: false' >> "$ES_YML"
  fi

  systemctl daemon-reload
  systemctl restart elasticsearch || true
  systemctl enable elasticsearch || true
  curl -X GET http://localhost:9200 || true
else
  echo "Elasticsearch config not found at $ES_YML. Run Practical 8 first."
fi

echo "Installing Graylog repository..."
wget -O "$GRAYLOG_REPO_DEB" "$GRAYLOG_REPO_URL"
dpkg -i "$GRAYLOG_REPO_DEB"

apt-get update
apt-get install -y graylog-server

password_secret="$(pwgen -N 1 -s 96)"
root_password_sha2="$(echo -n "$GRAYLOG_ADMIN_PASSWORD" | sha256sum | awk '{print $1}')"

escape_sed_replacement() {
  printf '%s' "$1" | sed -e 's/[&|\\]/\\&/g'
}

set_conf_value() {
  local key="$1"
  local value="$2"
  local escaped_value

  escaped_value="$(escape_sed_replacement "$value")"

  if grep -Eq "^[#[:space:]]*${key}[[:space:]]*=" "$GRAYLOG_CONF"; then
    sed -i -E "s|^[#[:space:]]*${key}[[:space:]]*=.*|${key} = ${escaped_value}|" "$GRAYLOG_CONF"
  else
    echo "${key} = ${value}" >> "$GRAYLOG_CONF"
  fi
}

set_conf_value "password_secret" "$password_secret"
set_conf_value "root_password_sha2" "$root_password_sha2"
set_conf_value "http_bind_address" "$GRAYLOG_HTTP_BIND_ADDRESS"
set_conf_value "http_external_uri" "$GRAYLOG_HTTP_EXTERNAL_URI"

echo "Starting and enabling Graylog..."
systemctl daemon-reload
systemctl restart graylog-server || systemctl start graylog-server
systemctl enable graylog-server

systemctl status graylog-server --no-pager || true

echo "Graylog URL: $GRAYLOG_HTTP_EXTERNAL_URI"

if [[ "$TAIL_LOGS" == "true" ]]; then
  tail -f /var/log/graylog-server/server.log
fi

echo "Practical 9 completed successfully."
