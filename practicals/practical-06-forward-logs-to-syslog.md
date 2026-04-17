# Practical 6: Configure Linux Client to Send Logs to Syslog Server

## Aim
Configure a Linux client to forward syslog messages to a central rsyslog server.

## Prerequisites
- Practical 5 completed on syslog server
- Server IP available (example: 192.168.137.50)

## Steps (Client Machine)

1. Update package index on client machine.

```bash
sudo apt-get update
```

2. Install rsyslog if needed.

```bash
sudo apt-get install -y rsyslog
```

3. Create forwarding configuration file.

```bash
sudo nano /etc/rsyslog.d/90-forward-to-server.conf
```

4. Add forwarding rule.

Use one of the following:

- UDP forwarding:

```conf
*.* @192.168.137.50:514
```

- TCP forwarding:

```conf
*.* @@192.168.137.50:514
```

5. Add queue reliability settings (recommended for forwarding).

```conf
$ActionQueueFileName queue
$ActionQueueMaxDiskSpace 1g
$ActionQueueSaveOnShutdown on
$ActionQueueType LinkedList
$ActionResumeRetryCount -1
```

6. Restart rsyslog service.

```bash
sudo systemctl restart rsyslog
```

7. Enable rsyslog service.

```bash
sudo systemctl enable rsyslog
```

8. Send a test log entry from client.

```bash
logger "SOC Practical 6 test message from $(hostname)"
```

## Verification (Server Machine)

1. Check whether client hostname folder appears.

```bash
ls -l /var/log
```

2. List received log files.

```bash
sudo find /var/log -maxdepth 2 -type f
```

3. If client hostname is known (example `kali`), monitor a log file.

```bash
sudo tail -f /var/log/kali/rsyslogd.log
```

## Expected Result
- Client logs are forwarded and stored on server under client hostname directory.
- Test message sent with `logger` is visible on server.
