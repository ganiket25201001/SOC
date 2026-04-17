# Practical 7: Install and Run Splunk on Linux

## Aim
Install Splunk Enterprise on Linux and access its web interface.

## Steps

1. Move to temporary directory.

```bash
cd /tmp
```

2. Download Splunk package.

```bash
wget https://download.splunk.com/products/splunk/releases/7.1.1/linux/splunk-7.1.1-8f0ead9ec3db-linux-2.6-amd64.deb
```

3. Install package.

```bash
sudo dpkg -i splunk-7.1.1-8f0ead9ec3db-linux-2.6-amd64.deb
```

If dependency errors appear:

```bash
sudo apt-get install -f -y
```

4. Start Splunk and accept license.

```bash
sudo /opt/splunk/bin/splunk start --accept-license
```

When prompted:
- Confirm license acceptance
- Create admin username/password

5. Enable Splunk to start at boot.

```bash
sudo /opt/splunk/bin/splunk enable boot-start --answer-yes
```

6. Check Splunk status.

```bash
sudo /opt/splunk/bin/splunk status
```

7. Access Splunk web interface:
- URL: http://localhost:8000/
- Login with admin credentials created above

## Expected Result
- Splunk service is running.
- Splunk web dashboard is accessible on port 8000.

## Notes
- If firewall is enabled, allow TCP port 8000.
