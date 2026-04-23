# Practical 1: Creating a Forensic Image using tools like FTK Imager, Guymager, dd (command-line tool).

## Content

Aim: To create a mathematically verifiable bit-stream copy of a digital device.
Prerequisites: 8GB USB Drive, FTK Imager (Windows), Guymager/dd (Kali).
Implementation 1: Windows Environment
Tool Used: AccessData FTK Imager
Step-by-Step Procedure:
Connect Evidence: Plug the suspect USB into the write-blocker, then connect the blocker to your workstation.
Launch FTK Imager: Right-click -> Run as Administrator.
Initiate Capture: Go to File -> Create Disk Image.
Select Source: Choose Physical Drive.
Never choose 'Logical Drive' unless you have a specific legal reason; you’ll miss the Master Boot Record (MBR) and unallocated space.
Select Device: Pick your USB drive (e.g., \\.\PhysicalDrive1). Click Finish.
Add Destination: Click Add... in the next window.
Choose Image Type: Select E01 (EnCase).
Why? E01 allows for compression and embeds case metadata (Examiner name, Case ID) directly into the file.
Evidence Details: Enter Case Number (e.g., MU/CYBER/2026/01), Evidence Number, and Notes.
Image Destination: * Select your sterilized drive folder.
Name the file (e.g., Suspect_USB_Image).
Verification: Ensure the box "Verify images after they are created" is checked. Click Start.
Result: Once finished, a "Hash Verification" box appears. Record the MD5 and SHA1 hashes for your report.
Implementation 2: Kali Linux Environment
Tools Used: dcfldd (Command Line) and Guymager (GUI)
Method A: The GUI Approach (Guymager)
Launch: Open Terminal and type sudo guymager.
Identify: Find your USB drive in the list (usually /dev/sdb or /dev/sdc).
Acquire: Right-click the drive -> Acquire Image.
Config: * Format: Expert Witness Compression, format .E01.
Metadata: Fill in Case ID and Examiner details.
Hashing: Check Calculate MD5 and Calculate SHA-256.
Start: Click OK. Guymager will turn the bar green once verified.
Method B: The Hardcore Approach (dcfldd)
Field Reality: When a GUI fails on a corrupted drive, we use dcfldd (the forensic version of dd from the DoD).
Identify: lsblk to find your device path.
Execute Command: sudo dcfldd if=/dev/sdb of=/home/kali/Desktop/evidence.dd hash=sha256 hashlog=hash_report.txt
if: Input File (Suspect Drive).
of: Output File (Forensic Image).
hash: Calculates the hash while it copies.

