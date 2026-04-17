# Practical 9: Install and Configure Graylog on Linux

## Aim
Install Graylog with Elasticsearch and MongoDB, then access the Graylog web interface.

## Prerequisite
- Practical 8 completed (Java + Elasticsearch base setup).

## Part 1: Prepare Elasticsearch for Graylog

1. Edit Elasticsearch config.

```bash
sudo nano /etc/elasticsearch/elasticsearch.yml
```

2. Set Graylog-compatible values:

```yaml
cluster.name: graylog
action.auto_create_index: false
```

3. Reload and restart Elasticsearch.

```bash
sudo systemctl daemon-reload
sudo systemctl start elasticsearch
sudo systemctl enable elasticsearch
```

4. Verify Elasticsearch endpoint.

```bash
curl -X GET http://localhost:9200
```

## Part 2: Install MongoDB

1. Install MongoDB package.

```bash
sudo apt update
sudo apt install -y mongodb-server
```

2. Start and enable MongoDB.

```bash
sudo systemctl start mongodb
sudo systemctl enable mongodb
```

## Part 3: Install Graylog Server

1. Add Graylog repository package.

```bash
wget https://packages.graylog2.org/repo/packages/graylog-4.2-repository_latest.deb
sudo dpkg -i graylog-4.2-repository_latest.deb
```

2. Update package cache and install Graylog.

```bash
sudo apt update
sudo apt install -y graylog-server
```

3. Generate password secret.

```bash
pwgen -N 1 -s 96
```

4. Generate SHA-256 hash for Graylog admin password.

```bash
echo -n "your_admin_password" | sha256sum
```

5. Edit server config.

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

6. Start and enable Graylog.

```bash
sudo systemctl daemon-reload
sudo systemctl start graylog-server
sudo systemctl enable graylog-server
```

7. Monitor startup logs.

```bash
sudo tail -f /var/log/graylog-server/server.log
```

8. Access Graylog UI in browser:
- http://<server_ip>:9000

## Expected Result
- Graylog server starts successfully.
- Web interface is reachable on port 9000.
