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
3. Configure network with DHCP script.

```bash
sudo ./lab.support.files/scripts/configure_as_dhcp.sh
```

4. Check interface configuration.

```bash
ifconfig
```

5. Test Internet reachability.

```bash
ping www.cisco.com
```

Press Ctrl+C to stop ping.

## Part 2: IDS Monitoring and Firewall Tuning

### A. Start Mininet and Snort

1. Start Mininet from the CyberOps terminal.

```bash
sudo ./lab.support.files/scripts/cyberops_extended_topo_no_fw.py
```

2. At the `mininet>` prompt, open R1 terminal.

```bash
xterm R1
```

3. In R1 terminal, start Snort.

```bash
./lab.support.files/scripts/start_snort.sh
```

4. Back at `mininet>` prompt, open H5 terminal.

```bash
xterm H5
```

5. Back at `mininet>` prompt, open H10 terminal.

```bash
xterm H10
```

6. In H10 terminal, start malware server.

```bash
./lab.support.files/scripts/mal_server_start.sh
```

7. In H10 terminal, verify listening service.

```bash
netstat -tunpa
```

8. Back at `mininet>`, open another R1 terminal for live alert monitoring.

```bash
xterm R1
```

9. In the second R1 terminal, monitor Snort alerts.

```bash
tail -f /var/log/snort/alert
```

### B. Trigger Alert and Capture Traffic

1. In H5 terminal, download the sample file with `wget` to trigger IDS.

```bash
wget 209.165.202.133:6666/W32.Nimda.Amm.exe
```

2. Alternative: download the same file with `curl`.

```bash
curl -O 209.165.202.133:6666/W32.Nimda.Amm.exe
```

3. Optional: start packet capture on H5.

```bash
tcpdump -i h5-eth0 -w nimda.download.pcap &
```

4. While capture is running, trigger download again.

```bash
curl -O 209.165.202.133:6666/W32.Nimda.Amm.exe
```

5. Bring tcpdump back to foreground.

```bash
fg
```

Press Ctrl+C to stop tcpdump.

6. Confirm capture file exists.

```bash
ls -l nimda.download.pcap
```

### C. Add Firewall Rule from IDS Findings

1. Open a third R1 terminal from `mininet>`.

```bash
xterm R1
```

2. Check current firewall rules.

```bash
iptables -L -v
```

3. Block access to malicious host and port.

```bash
iptables -I FORWARD -p tcp -d 209.165.202.133 --dport 6666 -j DROP
```

4. Re-check firewall rules.

```bash
iptables -L -v
```

5. Re-test download from H5. Connection should now be blocked.

## Part 3: Stop and Clean Mininet

1. In Mininet terminal, stop topology.

```bash
quit
```

2. Clean Mininet processes.

```bash
sudo mn -c
```

## Expected Result
- Snort creates alerts when malicious traffic crosses R1.
- iptables rule blocks further downloads to 209.165.202.133:6666.

## Notes
- Perform this practical only in an isolated lab environment.
- Keep the Snort alert window visible while generating traffic from H5.
