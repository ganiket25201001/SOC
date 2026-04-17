# Practical 8: Install and Configure ELK (Elasticsearch Focus) on Linux

## Aim
Install Java and Elasticsearch, then verify Elasticsearch service.

## Part 1: Install Java

1. Update package index and install Java runtime.

```bash
sudo apt update
sudo apt install default-jre
```

2. Verify Java version.

```bash
java -version
```

## Part 2: Install and Configure Elasticsearch

1. Add Elasticsearch GPG key.

```bash
curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
```

2. Add Elasticsearch repository.

```bash
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
```

3. Update and install Elasticsearch.

```bash
sudo apt update
sudo apt install elasticsearch
```

4. Edit Elasticsearch config.

```bash
sudo nano /etc/elasticsearch/elasticsearch.yml
```

Set or uncomment:

```yaml
network.host: localhost
http.port: 9200
```

5. Start and enable Elasticsearch.

```bash
sudo systemctl start elasticsearch
sudo systemctl enable elasticsearch
```

6. Test service response.

```bash
curl -X GET "localhost:9200"
```

## Expected Result
- Elasticsearch is up and responding on port 9200.
