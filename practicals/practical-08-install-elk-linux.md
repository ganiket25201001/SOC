# Practical 8: Install and Configure ELK (Elasticsearch Focus) on Linux

## Aim
Install Java and Elasticsearch, then verify Elasticsearch service.

## Part 1: Install Java

1. Update package index.

```bash
sudo apt update
```

2. Install Java runtime and prerequisites.

```bash
sudo apt install -y default-jre curl gnupg apt-transport-https
```

3. Verify Java version.

```bash
java -version
```

## Part 2: Install and Configure Elasticsearch

1. Add Elasticsearch GPG key in keyring format.

```bash
curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elastic-archive-keyring.gpg
```

2. Add Elasticsearch repository.

```bash
echo "deb [signed-by=/usr/share/keyrings/elastic-archive-keyring.gpg] https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list
```

3. Update package index.

```bash
sudo apt update
```

4. Install Elasticsearch.

```bash
sudo apt install -y elasticsearch
```

5. Edit Elasticsearch config.

```bash
sudo nano /etc/elasticsearch/elasticsearch.yml
```

Set or uncomment:

```yaml
network.host: localhost
http.port: 9200
```

6. Reload systemd.

```bash
sudo systemctl daemon-reload
```

7. Start Elasticsearch.

```bash
sudo systemctl start elasticsearch
```

8. Enable Elasticsearch at boot.

```bash
sudo systemctl enable elasticsearch
```

9. Verify Elasticsearch service status.

```bash
sudo systemctl status elasticsearch --no-pager
```

10. Verify Elasticsearch HTTP response.

```bash
curl -X GET "http://localhost:9200"
```

## Expected Result
- Elasticsearch is running and responds on port 9200.
