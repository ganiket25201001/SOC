# Practical 6: Study volatile memory from a computer to identify running processes, loaded drivers, and other information using tools like Volatility Framework, FTK Imager, redline, etc. Use minimum three tools.

## Content

Aim: To analyze RAM for running processes, malware, and unsaved documents.
Prerequisites: Volatility 3 (Kali), FTK Imager (Memory Capture).
Implementation 1: Windows Environment
Phase A: Acquisition (FTK Imager)
Launch: Run FTK Imager as Administrator.
Capture: Click File -> Capture Memory....
Config: * Destination: Select your external drive.
Filename: memdump.mem.
Check "Include pagefile": This captures the pagefile.sys (data swapped to disk), which often contains older memory fragments.
Check "Create AD1 file": This creates a custom AccessData evidence container.
Execute: Click Capture Memory. Do not touch the computer while this is running to avoid "smearing" the memory.
Phase B: Analysis (Mandiant Redline)
Open: Launch Redline. Select "Analyze Data" -> "From a Saved Memory Dump".
Load: Point to your memdump.mem.
Triage: Use the "Analysis Session" to look at:
Processes: Look for odd names (e.g., svch0st.exe instead of svchost.exe).
Hierarchical View: See which process spawned which. A cmd.exe spawned by notepad.exe is a massive red flag.
Drivers: Check for unsigned drivers that could be rootkits.
Implementation 2: Kali Linux Environment
Tool Used: Volatility 3
Volatility 3 is the engine that runs elite DFIR labs. It is Python-based and requires no "profile" setup, unlike the older version 2.
Step-by-Step Procedure:
Installation/Setup: Ensure you have the symbols for the OS you are analyzing.
Process Listing (pslist):
python3 vol.py -f /path/to/memdump.mem windows.pslist
This shows a high-level list of processes. Note the PID (Process ID) and PPID (Parent PID).
Hidden Process Detection (psscan):
python3 vol.py -f /path/to/memdump.mem windows.psscan
Malware often unlinks itself from the process list. psscan finds these "ghost" processes by scanning for memory pool tags.
Network Connections (netscan):
python3 vol.py -f /path/to/memdump.mem windows.netscan
This shows which process was talking to which external IP. Essential for finding C2 (Command & Control) callbacks.
Command History (cmdline):
python3 vol.py -f /path/to/memdump.mem windows.cmdline
Shows exactly what was typed into the command prompt. This is often where we find the attacker's "footprints."


