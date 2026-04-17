# Practical 2: Demonstrate Snort and Firewall Rules

## Aim
Monitor IDS alerts with Snort and block malicious traffic using iptables.

## Lab Environment
- CyberOps Workstation VM
- Mininet lab topology
- Devices used: R1, H5, H10

## Part 1: Prepare Virtual Environment

1. In Oracle VirtualBox, set CyberOps Workstation adapter to Bridged mode.
2. Start CyberOps Workstation VM.
3. Configure network using DHCP script.

```bash
sudo ./lab.support.files/scripts/configure_as_dhcp.sh
```

4. Verify connectivity.

```bash
ifconfig
ping www.cisco.com
```

## Part 2: Firewall and IDS Logs

### Step 1: Real-Time IDS Monitoring

1. Start Mininet.

```bash
sudo ./lab.support.files/scripts/cyberops_extended_topo_no_fw.py
```

2. Open R1 terminal from Mininet.

```bash
xterm R1
```

3. Start Snort on R1.

```bash
./lab.support.files/scripts/start_snort.sh
```

4. Open terminals for H5 and H10.

```bash
xterm H5
xterm H10
```

5. Start malware web server on H10.

```bash
./lab.support.files/scripts/mal_server_start.sh
```

6. Verify service is listening on H10.

```bash
netstat -tunpa
```

7. Open another R1 terminal and monitor Snort alerts.

```bash
xterm R1
tail -f /var/log/snort/alert
```

8. From H5, download the test malware sample.

```bash
wget 209.165.202.133:6666/W32.Nimda.Amm.exe
# or
curl -O 209.165.202.133:6666/W32.Nimda.Amm.exe
```

9. Optional packet capture from H5.

```bash
tcpdump -i h5-eth0 -w nimda.download.pcap &
curl -O 209.165.202.133:6666/W32.Nimda.Amm.exe
fg
# press Ctrl+C to stop capture
```

10. Verify capture file exists.

```bash
ls -l
```

### Step 2: Tune Firewall Rule Based on Alert

1. Open third R1 terminal.

```bash
xterm R1
```

2. Review existing rules.

```bash
iptables -L -v
```

3. Add blocking rule for malicious host/port.

```bash
iptables -I FORWARD -p tcp -d 209.165.202.133 --dport 6666 -j DROP
```

4. Confirm rule is active.

```bash
iptables -L -v
```

5. Re-test file download from H5. It should be blocked.

## Part 3: Stop and Clean Mininet

1. In Mininet terminal, quit.

```bash
quit
```

2. Clean leftover Mininet processes.

```bash
sudo mn -c
```

## Expected Result
- Snort generates alerts when malware traffic crosses R1.
- iptables rule blocks further downloads to destination 209.165.202.133:6666.
