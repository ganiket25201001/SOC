# Practical 5: Create Your Own Syslog Server

## Aim
Install and configure an rsyslog server to receive remote logs.

## Steps

1. Check rsyslog service status.

```bash
sudo systemctl status rsyslog
```

2. If not installed, install rsyslog.

```bash
sudo apt-get update
sudo apt-get install rsyslog
```

3. Open rsyslog configuration file.

```bash
sudo nano /etc/rsyslog.conf
```

4. Enable UDP and TCP listeners by uncommenting or adding these lines:

```conf
module(load="imudp")
input(type="imudp" port="514")
module(load="imtcp")
input(type="imtcp" port="514")
```

5. Add remote log template before GLOBAL DIRECTIVES:

```conf
$template remote-incoming-logs,"/var/log/%HOSTNAME%/%PROGRAMNAME%.log"
*.* ?remote-incoming-logs
```

6. Restart rsyslog service.

```bash
sudo systemctl restart rsyslog
```

7. Confirm listener ports.

```bash
ss -tunelp | grep 514
```

8. Allow firewall rules for syslog traffic.

```bash
sudo ufw allow 514/tcp
sudo ufw allow 514/udp
```

9. Validate rsyslog configuration syntax.

```bash
sudo rsyslogd -N1 -f /etc/rsyslog.conf
```

## Expected Result
- Server listens on TCP/UDP port 514.
- Incoming logs are saved under /var/log/<hostname>/<program>.log.
