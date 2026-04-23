# Practical 9: Using tools like Test Disk, Recuva, PhotoRec, etc. recover the deleted or corrupted files from storage media. Use minimum three tools.

## Content

Aim: To recover corrupted or deleted files using signature and partition analysis.
Prerequisites: TestDisk, Recuva, PhotoRec.
Implementation 1: Windows Environment (PhotoRec Win)
Tool Used: PhotoRec (CLI-GUI hybrid)
Step-by-Step Procedure:
Launch: Extract the TestDisk folder and run photorec_win.exe as Administrator.
Select Drive: Highlight the target USB/Disk from the list and press Enter.
Partition Selection: Choose the partition to scan. If the drive is corrupted, choose [Whole disk].
File System Type: Choose [Other] (for FAT/NTFS/ext4) unless it's an old Mac/Unix system.
Scan Range: Select [Free] to scan only unallocated space (for deleted files) or [Whole] if the drive is corrupted.
File Selection (Optional): Press s to disable all file types, then select only what you need (e.g., jpg, pdf, doc) to speed up the process.
Destination: Use the arrow keys to navigate to a folder on your C: drive or an external drive. Press C to start the recovery.
Implementation 2: Kali Linux Environment
Tool Used: photorec (Command Line)
Step-by-Step Procedure:
Identify Target: Run sudo fdisk -l to find your device path (e.g., /dev/sdb).
Launch: Type sudo photorec /dev/sdb.
Configuration: The interface is identical to the Windows version. Follow the same logic:
Select partition.
Select File System type.
Choose the destination directory (ensure you have write permissions).
Observation: Watch the terminal as PhotoRec lists the files it finds in real-time.
Implementation 1: Kali Linux (TestDisk)
Analyze: sudo testdisk /dev/sdb. Select Partition Table Type.
Undelete: Navigate to [ Advanced ] > [ Undelete ]. Select files (in red) and press 'C' to copy.
Implementation 2: Windows (Recuva)
Scan: Run "Deep Scan" on the drive.
Interpret: Note the "Green/Orange/Red" status. Red means the clusters were overwritten recovery is impossible.
