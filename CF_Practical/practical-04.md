# Practical 4: Extract and analysis registry data using tools like FTK Imager, Autopsy, Registry Explorer, etc. Use minimum three tools.

## Content

Aim: To extract user activity, typed URLs, and recently accessed files from registry hives.
Prerequisites: Registry Explorer (EZTools), Autopsy.
Implementation 1: Windows Environment
Tools Used: FTK Imager (Extraction) & Registry Explorer (Analysis)
Step-by-Step Procedure:
Extraction via FTK Imager:
Open your forensic image in FTK Imager.
Navigate to [Partition]\Windows\System32\config.
Right-click the SYSTEM and SOFTWARE files and select Export Files....
Navigate to the user profile: [Partition]\Users\[Username]\.
Export NTUSER.DAT.
Analysis via Registry Explorer:
Launch RegistryExplorer.exe.
Go to File -> Load Hive. Select your exported NTUSER.DAT.
User Activity: Navigate to Software\Microsoft\Windows\CurrentVersion\Explorer\UserAssist. Look for the {CEBFF5CD...} keys. These show a list of programs executed, their run counts, and the last execution time (usually ROT13 encoded, but Registry Explorer decodes it for you).
Automated Analysis via Autopsy:
In your Autopsy case, run the Recent Activity ingest module.
Once done, expand the "Data Artifacts" section in the left pane. Click on "Operating System User Account" and "Program Run" to see the Registry data correlated into a readable table.
Implementation 2: Kali Linux Environment
Tool Used: RegRipper (rip.pl)
RegRipper is the king of CLI registry analysis. It uses "plugins" to extract specific data so you don't have to manually hunt through keys.
Step-by-Step Procedure:
Locate Hives: Ensure your forensic image is mounted or you have the exported hives in your Kali directory.
Run RegRipper:
# To see all available plugins for a User hive:
rip.pl -h
# To run a full report on the NTUSER.DAT hive:
rip.pl -r /path/to/NTUSER.DAT -p ntuser > ntuser_report.txt
Analyze Output: Open ntuser_report.txt.
Search for TypedURLs: This shows what the user manually typed into the Windows Explorer bar.
Search for WinRAR: If the suspect compressed files before stealing them (exfiltration), the MRU (Most Recently Used) list will be here.

