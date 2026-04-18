# Practical 5: Create Your Own Syslog Server

## Aim
Install and configure an rsyslog server to receive remote logs.

## Tips
- Use Ubuntu and follow commands only.

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

4. Edit the main rsyslog configuration file.

```bash
sudo nano /etc/rsyslog.conf
```

5. Uncomment the UDP and TCP reception lines:

```conf
# provides UDP syslog reception
module(load="imudp")
input(type="imudp" port="514")

# provides TCP syslog reception
module(load="imtcp")
input(type="imtcp" port="514")
```

6. Add the template right before the `#### GLOBAL DIRECTIVES ####` section:

```conf
$template remote-incoming-logs,"/var/log/%HOSTNAME%/%PROGRAMNAME%.log"
*.* ?remote-incoming-logs
```

7. Validate rsyslog configuration syntax.

```bash
sudo rsyslogd -N1
```

8. Restart rsyslog service.

```bash
sudo systemctl restart rsyslog
```

9. Enable rsyslog service.

```bash
sudo systemctl enable rsyslog
```

10. Confirm syslog listener ports are active.

```bash
ss -tunelp | grep ':514'
```

11. If UFW is enabled, allow TCP syslog port.

```bash
sudo ufw allow 514/tcp
```

12. If UFW is enabled, allow UDP syslog port.

```bash
sudo ufw allow 514/udp
```

13. Check incoming log folder structure.

```bash
ls -l /var/log
```

14. To verify configuration, run the following command:

```bash
sudo rsyslogd -N1 -f /etc/rsyslog.conf
```

## Expected Result
- Server listens on TCP and UDP port 514.
- Remote logs are stored under `/var/log/<hostname>/<program>.log`.
