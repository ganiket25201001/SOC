# Practical 7: Examine email files to identify senders, recipients, attachments, and other information using tools like FTK Imager, EnCase Forensic Toolkit, MailX (command-line tool), etc. Use minimum three tools

## Content

Aim: To analyze email headers (IP addresses, X-headers) and attachments.
Prerequisites: Autopsy (Windows), mailx or specialized MBOX viewer.
Implementation 1: Windows Environment
Tool A: FTK Imager (Quick Triage)
Load: Click File -> Add Evidence Item -> Contents of a Folder. Point it to your email files.
View Raw: Select an .eml or .msg file. In the viewer pane, switch to the "Text" or "Hex" tab.
Identify Headers: Look for the blocks starting with Delivered-To:, Received:, and Return-Path:. Copy these out for analysis.
Tool B: Autopsy (Automated Extraction)
Add Data: Create a case and add your .pst or .mbox file as a data source.
Ingest: Run the Email Parser module.
Analyze: * Navigate to the "Email Messages" node in the Results tree.
Autopsy will automatically categorize senders, recipients, and timestamps.
Click the "Attachments" tab to see every file sent with the emails. Right-click to extract and hash them.
Implementation 2: Kali Linux Environment
Tool Used: mailx and Command-Line Utilities
When dealing with massive .mbox files (like a Google Takeout export), GUIs will freeze. You need the power of the terminal.
Step-by-Step Procedure:
Read Raw Mail: Use mailx to open a mailbox file.
mail -f suspect_mailbox.mbox
Filter Headers with Grep: To find the originating IP addresses in a large file:
grep "Received: from" suspect_mailbox.mbox | awk '{print $4}' | sort | uniq -c
This command identifies every server name mentioned in the "Received" headers and counts how many times they appear.
Extract Attachments (using munpack):
sudo apt install mpack
munpack suspect_email.eml
This will strip the MIME encoding and save the actual attachment (e.g., invoice.pdf.exe) to your current directory.



