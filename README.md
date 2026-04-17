# SOC Practical Journal - Quick Read Guide

This guide maps all practicals into separate Markdown files and gives you one script to view one practical or all practicals.

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

## How to Use These Files

1. Open this file first.
2. Pick the practical number you want.
3. Open the related Markdown file from practicals folder.
4. Follow commands in order.
5. Verify expected result at the end of each file.

## Run Helper Script

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

## Important Notes

- These practicals are lab procedures, not a single executable software project.
- Practical 2 and Practical 3 use malware sample names in a controlled lab context.
- Practical 5 is required before Practical 6.
- Practical 8 is required before Practical 9.
