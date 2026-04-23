# Practical 2: Use data carving tools like FTK Imager, Autopsy, Scalpel, etc. to recover deleted or hidden data from a digital device. Use minimum three tools.

## Content

Aim: To recover files based on file signatures (headers/footers) from unallocated space.
Prerequisites: Forensic Image from Prac 1, Autopsy (Windows), Scalpel (Kali).
Implementation 1: Windows Environment
Tool A: Autopsy (The Heavy Lifter)
Case Setup: Open Autopsy. Create a New Case. Name it PRAC_02_CARVING.
Add Data Source: Select Disk Image. Point to your .E01 or .dd file from Practical 1.
Configure Ingest Modules: This is the most important step.
Ensure File Recovery and PhotoRec Carver are checked.
Autopsy uses the PhotoRec engine under the hood for carving. It’s powerful but slow.
Analysis: Once ingest is complete, look at the Views tab in the left sidebar.
Extraction: Navigate to File Types -> Deleted Files. Autopsy will show files it successfully "carved" from unallocated space.
Verify: Right-click a recovered image, select View in Hex to ensure the header matches the file type.
Tool B: FTK Imager (Quick Extraction)
Add Evidence: Click File -> Add Evidence Item. Select Image File.
Browse Unallocated: In the Evidence Tree, look for folders with a red 'X' (deleted) or the entry for [unallocated space].
Export: Right-click the deleted file/unallocated block and select Export Files....
Reality Check: FTK Imager is better at recovering files that are still indexed in the MFT but marked deleted. For deep carving of overwritten metadata, Autopsy/PhotoRec is superior.
Implementation 2: Kali Linux Environment
Tool C: Scalpel (High-Speed CLI Carver)
Configuration: Scalpel doesn't just run; you have to tell it what to look for.
sudo nano /etc/scalpel/scalpel.conf
Scroll down and uncomment (remove the #) the lines for the file types you want to recover (e.g., jpg, png, pdf, doc). Save and exit (Ctrl+O, Enter, Ctrl+X).
Execution: Run the carving command.
sudo scalpel -o /home/kali/Desktop/recovered_data/ /home/kali/Desktop/evidence.dd
-o: Output directory (must be empty or new).
evidence.dd: Your source image.
Audit: Scalpel will generate an audit.txt in the output folder. This is your forensic log. It tells you exactly where (offset) in the image the file was found.


