# Practical 9 Cheatsheet: Deleted and Corrupted File Recovery

## Objective
Recover deleted or damaged files using signature carving and partition analysis.

## Aim (From CF.txt)
To recover corrupted or deleted files using signature and partition analysis.

## Tools
- Windows: PhotoRec, Recuva
- Kali: PhotoRec, TestDisk

## Windows Steps (PhotoRec)
1. Run photorec_win.exe as Administrator.
2. Select target disk/USB.
3. Choose partition or Whole disk if partition table is damaged.
4. Select filesystem type (usually Other for FAT/NTFS/ext).
5. Choose Free (deleted space) or Whole (corrupt media).
6. Optionally limit file types to speed up recovery.
7. Select destination folder on a different drive.
8. Start recovery and review output folders.

## Kali Steps (PhotoRec)
1. Identify target device:
```bash
sudo fdisk -l
```
2. Launch PhotoRec:
```bash
sudo photorec /dev/sdb
```
3. Follow on-screen flow: partition, filesystem, destination, recovery mode.

## Kali Steps (TestDisk)
1. Start TestDisk:
```bash
sudo testdisk /dev/sdb
```
2. Select partition table type.
3. Go to Advanced > Undelete.
4. Select deleted entries and press C to copy.

## Windows Steps (Recuva)
1. Run deep scan on target media.
2. Prioritize files with Green status.
3. Treat Red status as likely unrecoverable (overwritten clusters).

## Report Checklist
1. Tool and mode used (Free vs Whole, Deep Scan, Undelete)
2. Recovered file count by type
3. Recovery status and integrity notes
4. Destination path and hash values

## Critical Notes
- Always recover to a separate destination drive.
- Overwritten clusters usually cannot be restored.
