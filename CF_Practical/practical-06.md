# Practical 6 Cheatsheet: Volatile Memory Analysis

## Objective
Analyze RAM to identify suspicious processes, drivers, network activity, and command history.

## Tools
- Windows: FTK Imager (capture), Mandiant Redline (analysis)
- Kali: Volatility 3

## Windows Steps (Memory Capture)
1. Run FTK Imager as Administrator.
2. Go to File > Capture Memory.
3. Set destination and filename (example: memdump.mem).
4. Enable Include pagefile.
5. Optionally enable Create AD1 file.
6. Start capture and avoid interacting with the host during acquisition.

## Windows Steps (Redline Triage)
1. Open Redline and choose Analyze Data > From a Saved Memory Dump.
2. Load memdump.mem.
3. Review process list and process tree.
4. Flag suspicious names (for example: svch0st.exe).
5. Review unsigned or suspicious drivers.

## Kali Steps (Volatility 3)
1. List processes:
```bash
python3 vol.py -f /path/to/memdump.mem windows.pslist
```
2. Scan for hidden processes:
```bash
python3 vol.py -f /path/to/memdump.mem windows.psscan
```
3. Check network connections:
```bash
python3 vol.py -f /path/to/memdump.mem windows.netscan
```
4. Recover command-line history:
```bash
python3 vol.py -f /path/to/memdump.mem windows.cmdline
```

## Report Checklist
1. Memory image filename and size
2. Suspicious PID/PPID relationships
3. External IP connections
4. Command execution traces

## Critical Notes
- Memory is volatile; capture early.
- Correlate process findings with network and command artifacts.
