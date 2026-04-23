# Practical 3 Cheatsheet: File System Analysis (TSK)

## Objective
Analyze file system structure, metadata, inodes, and timeline artifacts.

## Tools
- Windows: Autopsy, FTK Imager
- Kali: Sleuth Kit (mmls, fsstat, fls, istat, icat)

## Windows Steps
1. Create Autopsy case and add forensic image.
2. Navigate directory tree and identify deleted items (red X).
3. Open file Metadata tab and note MFT/Inode values.
4. Review timeline activity for suspicious periods.
5. Open same image in FTK Imager and compare file times.
6. If timestamps differ, verify timezone handling before reporting.

## Kali Steps (TSK CLI)
1. Find partition start sector:
```bash
mmls evidence.dd
```
2. Inspect filesystem details (replace 2048 with actual offset):
```bash
fsstat -o 2048 evidence.dd
```
3. List files recursively:
```bash
fls -o 2048 -r evidence.dd
```
4. Inspect inode metadata:
```bash
istat -o 2048 evidence.dd <inode_number>
```
5. Extract file by inode:
```bash
icat -o 2048 evidence.dd <inode_number> > recovered_file.bin
```

## Report Checklist
1. Partition offset used
2. Inode numbers examined
3. MACB timestamps observed
4. Extracted file names and hashes

## Critical Notes
- Wrong offset gives meaningless output.
- Always document timezone assumptions for timeline evidence.
