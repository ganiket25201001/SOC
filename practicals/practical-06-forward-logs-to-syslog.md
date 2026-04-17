# Practical 6: Configure Linux Client to Send Logs to Syslog Server

## Aim
Configure a Linux client to forward syslog messages to a central rsyslog server.

## Prerequisite
- Practical 5 completed on syslog server.
- Syslog server IP example: 192.168.137.50

## Steps

1. On client machine, install rsyslog.

```bash
sudo apt-get update
sudo apt-get install rsyslog
```

2. Open rsyslog config.

```bash
sudo nano /etc/rsyslog.conf
```

3. Add forwarding rule at end of file.

Use either UDP or TCP:

```conf
*.* @192.168.137.50:514
```

```conf
*.* @@192.168.137.50:514
```

4. Add queue settings for reliability if server is temporarily unavailable.

```conf
$ActionQueueFileName queue
$ActionQueueMaxDiskSpace 1g
$ActionQueueSaveOnShutdown on
$ActionQueueType LinkedList
$ActionResumeRetryCount -1
```

5. Save file and restart service.

```bash
sudo systemctl restart rsyslog
```

6. Verify on server side that client host directory is created.

```bash
ls /var/log/
```

7. Inspect incoming client logs on server.

```bash
sudo tail -f /var/log/kali/rsyslogd.log
```

## Expected Result
- Client logs are forwarded to the server and stored under server-side host directory.
