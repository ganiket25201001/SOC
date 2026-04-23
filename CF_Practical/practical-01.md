# Practical 1 Cheatsheet: Forensic Imaging

## Objective
Create a bit-stream forensic image of a device and verify integrity hashes.

## Aim (From CF.txt)
To create a mathematically verifiable bit-stream copy of a digital device.

## Tools
- Windows: FTK Imager
- Kali: Guymager, dcfldd
- Hardware: Write blocker, suspect USB/storage, sterile destination drive

## Windows Steps (FTK Imager)
1. Connect the suspect device through a write blocker.
2. Open FTK Imager as Administrator.
3. Go to File > Create Disk Image > Physical Drive.
4. Select the correct source device (for example: \\.\PhysicalDrive1).
5. Choose E01 image format.
6. Enter case details (Case ID, Evidence ID, Examiner, Notes).
7. Choose destination path and image name.
8. Enable Verify images after they are created.
9. Start acquisition and wait for completion.
10. Record MD5 and SHA1 from the hash verification window.

## Kali Steps (Guymager)
1. Launch Guymager:
```bash
sudo guymager
```
2. Identify the suspect device (/dev/sdb, /dev/sdc, etc.).
3. Right-click device and select Acquire Image.
4. Select E01 format and fill metadata.
5. Enable MD5 and SHA-256 hashing.
6. Start imaging and wait for verified status.

## Kali Steps (dcfldd)
1. Identify the source drive:
```bash
lsblk
```
2. Acquire image and hash in one pass:
```bash
sudo dcfldd if=/dev/sdb of=/home/kali/Desktop/evidence.dd hash=sha256 hashlog=hash_report.txt
```

## Report Checklist
1. Source device identifier
2. Image path and filename
3. Tool name and version
4. Hash values (MD5/SHA1/SHA256)
5. Case metadata and timestamp

## Critical Notes
- Prefer Physical Drive capture, not Logical Drive.
- Logical capture may miss MBR and unallocated space.
