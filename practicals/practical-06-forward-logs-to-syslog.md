# Practical 6: Forward Logs to Syslog Server

## Aim
Configure your Linux system to send syslog messages to a syslog server and read them.

## Prerequisites
- Practical 5 (rsyslog server setup) is completed.
- Syslog server IP address is available (example: 192.168.137.50).

## Steps

1. Install and configure rsyslog server first. For this, refer Practical 5.

2. Open Kali Linux and install rsyslog using the following commands:

```bash
sudo apt-get update && sudo apt-get install rsyslog
```

3. Open rsyslog configuration file:

```bash
sudo nano /etc/rsyslog.conf
```

4. Add the following lines at the end of the file:

```conf
@192.168.137.50:514
*.* @@192.168.137.50:514
```

Note: Use `@` to send logs over UDP. Use `@@` for TCP.

5. Add the following queue variables:

```conf
$ActionQueueFileName queue
$ActionQueueMaxDiskSpace 1g
$ActionQueueSaveOnShutdown on
$ActionQueueType LinkedList
$ActionResumeRetryCount -1
```

6. Save and exit the file.

7. Restart the rsyslog service:

```bash
sudo systemctl restart rsyslog
```

8. Go to your rsyslog server to verify logs from your client machine:

```bash
ls /var/log/
```

In this example, `kali` is the client machine name.

9. To check logs, inspect rsyslogd.log:

```bash
sudo tail -f /var/log/kali/rsyslogd.log
```

## Expected Result
- Syslog messages from the client are forwarded to the rsyslog server.
- A client hostname directory (for example, `kali`) appears under `/var/log/` on the server.
- Logs such as `rsyslogd.log` can be read from that client directory.
