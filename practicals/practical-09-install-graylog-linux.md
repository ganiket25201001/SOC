# Practical 9: Install and Configure Graylog on Linux

## Aim
Install Graylog with Elasticsearch and MongoDB, then access the Graylog web interface.

## Tips
- Use Ubuntu and follow commands only.

## Prerequisites
- Practical 8 completed (Java + Elasticsearch installed)
- Server has Internet access

## Part 1: Prepare Elasticsearch for Graylog

1. Edit Elasticsearch config.

```bash
sudo nano /etc/elasticsearch/elasticsearch.yml
```

2. Set Graylog-compatible values.

```yaml
cluster.name: graylog
action.auto_create_index: false
```

3. Reload systemd configuration.

```bash
sudo systemctl daemon-reload
```

4. Restart Elasticsearch.

```bash
sudo systemctl restart elasticsearch
```

5. Enable Elasticsearch at boot.

```bash
sudo systemctl enable elasticsearch
```

6. Verify Elasticsearch endpoint.

```bash
curl -X GET http://localhost:9200
```

## Part 2: Install MongoDB

1. Update package index.

```bash
sudo apt update
```

2. Install MongoDB package.

```bash
sudo apt install -y mongodb-server
```

If `mongodb-server` is unavailable on your distro, install the distro-supported MongoDB package instead.

3. Start MongoDB service.

```bash
sudo systemctl start mongodb
```

4. If the command above fails, start `mongod` service instead.

```bash
sudo systemctl start mongod
```

5. Enable MongoDB service at boot.

```bash
sudo systemctl enable mongodb
```

6. If the command above fails, enable `mongod` service instead.

```bash
sudo systemctl enable mongod
```

## Part 3: Install Graylog Server

1. Install required utility for password secret generation.

```bash
sudo apt install -y pwgen
```

2. Download Graylog repository package.

```bash
wget https://packages.graylog2.org/repo/packages/graylog-4.2-repository_latest.deb
```

3. Install Graylog repository package.

```bash
sudo dpkg -i graylog-4.2-repository_latest.deb
```

4. Update package cache.

```bash
sudo apt update
```

5. Install Graylog server.

```bash
sudo apt install -y graylog-server
```

6. Generate Graylog password secret.

```bash
pwgen -N 1 -s 96
```

7. Generate SHA-256 hash for Graylog admin password.

```bash
echo -n "your_admin_password" | sha256sum
```

8. Edit Graylog config.

```bash
sudo nano /etc/graylog/server/server.conf
```

Set these fields (example values):

```conf
password_secret = <output_of_pwgen>
root_password_sha2 = <output_of_sha256sum>
http_bind_address = 0.0.0.0:9000
http_external_uri = http://<server_ip>:9000/
```

9. Reload systemd configuration.

```bash
sudo systemctl daemon-reload
```

10. Start Graylog service.

```bash
sudo systemctl start graylog-server
```

11. Enable Graylog service at boot.

```bash
sudo systemctl enable graylog-server
```

12. Check Graylog service status.

```bash
sudo systemctl status graylog-server --no-pager
```

13. Monitor Graylog server logs.

```bash
sudo tail -f /var/log/graylog-server/server.log
```

14. Access Graylog web UI:
- http://<server_ip>:9000

## Expected Result
- Graylog service starts without errors.
- Web interface is reachable on port 9000.
