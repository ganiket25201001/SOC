# Practical 3: Extract an Executable from a PCAP

## Aim
Use Wireshark to identify and export an executable transferred over HTTP from a packet capture.

## Lab Environment
- CyberOps Workstation VM
- Capture file: nimda.download.pcap

## Steps

1. Open terminal and move to PCAP folder.

```bash
cd /home/analyst/lab.support.files/pcaps
```

2. Verify capture file exists.

```bash
ls -l nimda.download.pcap
```

3. Open the capture in Wireshark.

```bash
wireshark nimda.download.pcap
```

If `wireshark` is unavailable, try:

```bash
wireshark-gtk nimda.download.pcap
```

4. In Wireshark, apply a filter to focus on HTTP traffic.

```text
http
```

5. Find the HTTP transfer for the malware object and inspect details:
- Identify source host and full URL
- Right-click related packet
- Select Follow > TCP Stream

6. Note the original filename shown in stream or HTTP headers.

7. Export file object from Wireshark UI:
- File > Export Objects > HTTP
- Select W32.Nimda.Amm.exe
- Click Save As

8. Verify exported file from terminal.

```bash
ls -l W32.Nimda.Amm.exe
```

9. Check file type from terminal.

```bash
file W32.Nimda.Amm.exe
```

10. Optional safe validation: submit file hash to VirusTotal from an isolated lab system.

## Expected Result
- Executable is successfully extracted from the PCAP.
- File metadata confirms executable content.

## Notes
- Do not execute the extracted file.
- Keep analysis strictly in a controlled lab environment.
