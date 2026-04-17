#!/usr/bin/env bash
set -euo pipefail

if [[ "${EUID}" -ne 0 ]]; then
  echo "Error: Run as root (sudo)."
  exit 1
fi

ELASTIC_KEYRING="/usr/share/keyrings/elastic-archive-keyring.gpg"
ELASTIC_LIST="/etc/apt/sources.list.d/elastic-7.x.list"
ES_YML="/etc/elasticsearch/elasticsearch.yml"

echo "Installing Java and prerequisites..."
apt-get update
apt-get install -y default-jre curl gnupg apt-transport-https
java -version || true

echo "Adding Elasticsearch repository key and source..."
curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | gpg --dearmor -o "$ELASTIC_KEYRING"
echo "deb [signed-by=$ELASTIC_KEYRING] https://artifacts.elastic.co/packages/7.x/apt stable main" > "$ELASTIC_LIST"

echo "Installing Elasticsearch..."
apt-get update
apt-get install -y elasticsearch

set_yaml_key() {
  local key="$1"
  local value="$2"
  if grep -Eq "^[#[:space:]]*${key}:" "$ES_YML"; then
    sed -i -E "s|^[#[:space:]]*${key}:.*|${key}: ${value}|" "$ES_YML"
  else
    echo "${key}: ${value}" >> "$ES_YML"
  fi
}

set_yaml_key "network.host" "localhost"
set_yaml_key "http.port" "9200"

echo "Starting and enabling Elasticsearch..."
systemctl daemon-reload
systemctl start elasticsearch
systemctl enable elasticsearch

echo "Testing Elasticsearch response..."
curl -X GET "http://localhost:9200" || true

echo "Practical 8 completed successfully."
