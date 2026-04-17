# Practical 5: Create Your Own Syslog Server

## Aim
Install and configure an rsyslog server to receive remote logs.

## Steps

1. Check current rsyslog status.

```bash
sudo systemctl status rsyslog
```

2. Update package index.

```bash
sudo apt-get update
```

3. Install rsyslog if required.

```bash
sudo apt-get install -y rsyslog
```

4. Create a dedicated remote logging config file.

```bash
sudo nano /etc/rsyslog.d/90-remote.conf
```

5. Add the following configuration:

```conf
module(load="imudp")
input(type="imudp" port="514")

module(load="imtcp")
input(type="imtcp" port="514")

$template remote-incoming-logs,"/var/log/%HOSTNAME%/%PROGRAMNAME%.log"
*.* ?remote-incoming-logs
```

6. Validate rsyslog configuration syntax.

```bash
sudo rsyslogd -N1
```

7. Restart rsyslog service.

```bash
sudo systemctl restart rsyslog
```

8. Enable rsyslog service.

```bash
sudo systemctl enable rsyslog
```

9. Confirm syslog listener ports are active.

```bash
ss -tunelp | grep ':514'
```

10. If UFW is enabled, allow TCP syslog port.

```bash
sudo ufw allow 514/tcp
```

11. If UFW is enabled, allow UDP syslog port.

```bash
sudo ufw allow 514/udp
```

12. Check incoming log folder structure.

```bash
ls -l /var/log
```

## Expected Result
- Server listens on TCP and UDP port 514.
- Remote logs are stored under `/var/log/<hostname>/<program>.log`.
