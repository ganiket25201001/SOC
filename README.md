# SOC Practical Journal - Quick Read Guide

This guide maps all practicals into separate Markdown files and gives you one script to view one practical or all practicals.

This repository currently contains two practical sets:

1. `practicals/` (SOC practical set with 10 practicals)
2. `CF_Practical/` (CF practical set generated from `CF,txt`)

## Practical Index

1. [Practical 1 - Encrypting and Decrypting Data Using OpenSSL](practicals/practical-01-openssl.md)
2. [Practical 2 - Demonstrate the Use of Snort and Firewall Rules](practicals/practical-02-snort-firewall.md)
3. [Practical 3 - Demonstrate Extract an Executable from a PCAP](practicals/practical-03-extract-exe-from-pcap.md)
4. [Practical 4 - Demonstrate Analysis of DNS Traffic](practicals/practical-04-dns-traffic-analysis.md)
5. [Practical 5 - Create Your Own Syslog Server](practicals/practical-05-rsyslog-server.md)
6. [Practical 6 - Configure Linux to Send Syslog Messages to a Syslog Server and Read Them](practicals/practical-06-forward-logs-to-syslog.md)
7. [Practical 7 - Install and Run Splunk on Linux](practicals/practical-07-install-splunk-linux.md)
8. [Practical 8 - Install and Configure ELK on Linux](practicals/practical-08-install-elk-linux.md)
9. [Practical 9 - Install and Configure Graylog on Linux](practicals/practical-09-install-graylog-linux.md)
10. [Practical 10 - Demonstrate Conversion of Data into a Universal Format](practicals/practical-10-convert-data-universal-format.md)

## CF Practical Index

Source file: `CF,txt`

1. [Practical 1 - Creating a Forensic Image using tools like FTK Imager, Guymager, dd (command-line tool).](CF_Practical/practical-01.md) - 
2. [Practical 2 - Use data carving tools like FTK Imager, Autopsy, Scalpel, etc. to recover deleted or hidden data from a digital device. Use minimum three tools.](CF_Practical/practical-02.md) 
3. [Practical 3 - File System Analysis using the Sleuth Kit (TSK).](CF_Practical/practical-03.md) 
4. [Practical 4 - Extract and analysis registry data using tools like FTK Imager, Autopsy, Registry Explorer, etc. Use minimum three tools.](CF_Practical/practical-04.md) 
5. [Practical 5 - Perform network forensics using tools like Wireshark, NetworkMiner, tcpdump, etc. Use minimum three tools.](CF_Practical/practical-05.md)
6. [Practical 6 - Study volatile memory from a computer to identify running processes, loaded drivers, and other information using tools like Volatility Framework, FTK Imager, redline, etc. Use minimum three tools.](CF_Practical/practical-06.md)
7. [Practical 7 - Examine email files to identify senders, recipients, attachments, and other information using tools like FTK Imager, EnCase Forensic Toolkit, MailX (command-line tool), etc. Use minimum three tools.](CF_Practical/practical-07.md) 
8. [Practical 8 - Study internet artifact analysis to examine web browsing history, chat logs, and other internet artifacts to identify user activity using Browser History Examiner and ChromeCacheViewer.](CF_Practical/practical-08.md) 
9. [Practical 9 - Using tools like Test Disk, Recuva, PhotoRec, etc. recover the deleted or corrupted files from storage media. Use minimum three tools.](CF_Practical/practical-09.md) 

## How to Use These Files

1. Open this file first.
2. Pick the practical number you want.
3. Open the related Markdown file from `practicals/` or `CF_Practical/`.
4. Follow commands in order.
5. Verify expected result at the end of each file.

## Run Helper Script

These helper scripts target files in `practicals/`.

PowerShell script available: run-practical.ps1
Linux shell script available: run-practical.sh

Common commands:

```powershell
# List all practical files
powershell -ExecutionPolicy Bypass -File .\run-practical.ps1 -List

# Show one practical in terminal (example: Practical 3)
powershell -ExecutionPolicy Bypass -File .\run-practical.ps1 -Number 3

# Show all practicals in terminal
powershell -ExecutionPolicy Bypass -File .\run-practical.ps1 -All

# Open one practical file in default app (example: Practical 7)
powershell -ExecutionPolicy Bypass -File .\run-practical.ps1 -Number 7 -Open

# Open all practical files in default app
powershell -ExecutionPolicy Bypass -File .\run-practical.ps1 -All -Open
```

```bash
# Make script executable (Linux)
chmod +x ./run-practical.sh

# List all practical files
./run-practical.sh --list

# Show one practical in terminal (example: Practical 3)
./run-practical.sh --number 3

# Show all practicals in terminal
./run-practical.sh --all

# Open one practical file in default app (example: Practical 7)
./run-practical.sh --number 7 --open

# Open all practical files in default app
./run-practical.sh --all --open
```

## Practical Automation Scripts (.sh)

Scripts were created only where the practical can be automated end-to-end with CLI commands.

1. [Practical 1 Script](scripts/practical-01-openssl.sh)
2. [Practical 5 Script](scripts/practical-05-rsyslog-server.sh)
3. [Practical 7 Script](scripts/practical-07-install-splunk.sh)
4. [Practical 8 Script](scripts/practical-08-install-elk.sh)
5. [Practical 9 Script](scripts/practical-09-install-graylog.sh)
6. [Practical 10 Script](scripts/practical-10-normalize-logs.sh)

Use launcher script:

```bash
chmod +x ./scripts/*.sh

# List scriptable practicals
./scripts/run-scriptable-practicals.sh --list

# Run one scriptable practical
./scripts/run-scriptable-practicals.sh --number 8

# Run all scriptable practicals
./scripts/run-scriptable-practicals.sh --all
```

Required environment variables for some scripts:

```bash
export OPENSSL_PASS='YourOpenSSLPassword'
export SPLUNK_ADMIN_PASSWORD='YourSplunkAdminPassword'
export GRAYLOG_ADMIN_PASSWORD='YourGraylogAdminPassword'
```

Skipped practicals (not fully automatable end-to-end):

1. Practical 2 - Multi-terminal Mininet and live IDS interactions
2. Practical 3 - Wireshark GUI object export workflow
3. Practical 4 - Wireshark GUI packet exploration workflow
4. Practical 6 - Requires cross-host client/server verification sequence

## Important Notes

- These practicals are lab procedures, not a single executable software project.
- Practical 2 and Practical 3 use malware sample names in a controlled lab context.
- Practical 5 is required before Practical 6.
- Practical 8 is required before Practical 9.
