# Practical 4 Cheatsheet: Registry Extraction and Analysis

## Objective
Extract and analyze registry hives for user activity, typed URLs, and executed programs.

## Tools
- Windows: FTK Imager, Registry Explorer, Autopsy
- Kali: RegRipper (rip.pl)

## Windows Steps (FTK + Registry Explorer)
1. Open forensic image in FTK Imager.
2. Export hives:
   - [Partition]\\Windows\\System32\\config\\SYSTEM
   - [Partition]\\Windows\\System32\\config\\SOFTWARE
   - [Partition]\\Users\\<Username>\\NTUSER.DAT
3. Open NTUSER.DAT in Registry Explorer.
4. Navigate to UserAssist key:
   - Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\UserAssist
5. Record program execution artifacts and run counts.

## Windows Steps (Autopsy)
1. Run Recent Activity ingest module.
2. Review Data Artifacts such as Program Run and User Account entries.
3. Export relevant artifact tables for report.

## Kali Steps (RegRipper)
1. List available plugins:
```bash
rip.pl -h
```
2. Run NTUSER report:
```bash
rip.pl -r /path/to/NTUSER.DAT -p ntuser > ntuser_report.txt
```
3. Search report for TypedURLs, MRU lists, and execution traces.

## Report Checklist
1. Hive source paths
2. Key paths examined
3. Program execution artifacts
4. Typed URL and MRU findings

## Critical Notes
- Work on exported hive copies, not originals.
- Keep chain-of-custody details for each exported hive.
