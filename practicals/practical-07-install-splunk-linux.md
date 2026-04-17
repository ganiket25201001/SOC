# Practical 7: Install and Run Splunk on Linux

## Aim
Install Splunk Enterprise on Linux and access its web interface.

## Steps

1. Download Splunk package.

```bash
cd /tmp
wget https://download.splunk.com/products/splunk/releases/7.1.1/linux/splunk-7.1.1-8f0ead9ec3db-linux-2.6-amd64.deb
```

2. Install package.

```bash
sudo dpkg -i splunk-7.1.1-8f0ead9ec3db-linux-2.6-amd64.deb
```

3. Enable Splunk at boot and accept license.

```bash
sudo /opt/splunk/bin/splunk enable boot-start
```

When prompted:
- Review and accept license (type y)
- Set admin username/password

4. Start Splunk service.

```bash
sudo service splunk start
```

5. Check service status.

```bash
sudo service splunk status
```

6. Access Splunk web UI:
- URL: http://localhost:8000/
- Login with admin credentials created earlier

## Expected Result
- Splunk service runs successfully.
- Web dashboard is accessible on port 8000.
