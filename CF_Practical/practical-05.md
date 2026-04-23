# Practical 5 Cheatsheet: Network Forensics and Packet Analysis

## Objective
Capture and analyze network traffic to detect suspicious behavior, data exfiltration, and cleartext credentials.

## Aim (From CF.txt)
To capture and analyze traffic for suspicious patterns or unencrypted credentials.

## Tools
- Windows: Wireshark, NetworkMiner
- Kali: tcpdump
- Input: Live traffic or PCAP file

## Windows Steps (Wireshark)
1. Select active interface and start capture.
2. Apply filters as needed:
   - http
   - dns
   - ip.addr == <suspect_ip>
3. Use Follow TCP Stream to reconstruct conversations.
4. Export transferred files from File > Export Objects > HTTP.

## Windows Steps (NetworkMiner)
1. Open PCAP in NetworkMiner.
2. Review Files tab for transferred artifacts.
3. Review Images tab for viewed images.
4. Review Credentials tab for cleartext usernames/passwords.

## Kali Steps (tcpdump)
1. Capture full traffic:
```bash
sudo tcpdump -i eth0 -w internal_investigation.pcap
```
2. Capture targeted web ports:
```bash
sudo tcpdump -i eth0 'port 80 or port 443' -v
```
3. Read PCAP with suspect filter:
```bash
tcpdump -r internal_investigation.pcap 'tcp port 80 and src 192.168.1.5'
```

## Report Checklist
1. Capture interface and time window
2. Suspect source/destination IPs
3. Protocols observed
4. Extracted files and credential findings

## Critical Notes
- Validate capture source and integrity before legal submission.
- Prioritize insecure protocols (HTTP/FTP/Telnet/SMTP) for credential leaks.
