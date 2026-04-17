# Practical 3: Extract an Executable from a PCAP

## Aim
Use Wireshark to identify and export an executable transferred over HTTP from a packet capture.

## Lab Environment
- CyberOps Workstation VM
- File: nimda.download.pcap

## Steps

1. Open terminal and go to capture directory.

```bash
cd ./lab.support.files/pcaps/
ls -l
```

2. Open the capture in Wireshark.

```bash
wireshark-gtk nimda.download.pcap
```

3. In Wireshark, inspect HTTP traffic and identify host and full URL.
4. Right-click a related packet, then choose Follow > TCP Stream.
5. Note the original filename from stream contents.
6. Export the file from HTTP objects.

Path in UI:
- File > Export Objects > HTTP
- Select W32.Nimda.Amm.exe
- Click Save As

7. Verify the exported file in terminal.

```bash
ls -l
file W32.Nimda.Amm.exe
```

8. Optional validation: upload hash or file to VirusTotal in a safe environment.

## Expected Result
- The executable is recovered from the PCAP and saved locally.
- File metadata confirms it is an executable sample.
