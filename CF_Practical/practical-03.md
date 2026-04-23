# Practical 3: File System Analysis using the Sleuth Kit (TSK)

## Content

Aim: To analyze file system metadata, inodes, and directory structures.
Prerequisites: Kali Linux, TSK installed.
Implementation 1: Windows Environment
Tool Used: Autopsy & FTK Imager
Step-by-Step Procedure:
Load Image: Open Autopsy, create a new case, and add your forensic image as the data source.
Navigate File System: In the left-hand directory tree, expand the drive. Autopsy uses TSK under the hood to map out the folder structure, even for deleted items (marked with a red 'X').
Analyze Metadata: Select any file. In the bottom pane, click the Metadata tab.
Record the MFT Entry/Inode number.
Observe the Standard Information vs. File Name attributes (specific to NTFS).
Timeline Analysis: Use the "Timeline" tool in Autopsy to see when the file system was most active.
Cross-Verify with FTK Imager: Open the same image in FTK Imager. Click on a file and look at the Properties pane (bottom left). Compare the "MTIMES" with what Autopsy showed. If they differ, you have a time zone offset issue—a common mistake that ruins cases.
Implementation 2: Kali Linux Environment
Tool Used: The Sleuth Kit (TSK) CLI
This is where the real experts work. No GUI, just raw data analysis.
Step-by-Step Procedure:
Analyze Partition Table: Find the starting offset of the partition you want to analyze.
mmls evidence.dd
Look for the "Start" sector of the primary data partition (e.g., 2048).
Check File System Stats: Use fsstat with the offset to see block size and volume serial numbers.
fsstat -o 2048 evidence.dd
List Files & Directories: Use fls to see the contents of the root directory.
fls -o 2048 -r evidence.dd
-r: Recursive.
Look for entries starting with r/r (active) or d/d (deleted). Note the Inode number at the start of the line.
Deep Metadata Inspection: Use istat to see everything about a specific file using its Inode number.
istat -o 2048 evidence.dd [Inode_Number]
Observe the MACB times: Modified, Accessed, Changed (Metadata), and Birth (Created).
Extract Specific File: If you find a suspicious file, pull it out directly using its Inode.
icat -o 2048 evidence.dd [Inode_Number] > recovered_suspicious_file.txt


