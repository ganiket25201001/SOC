# Practical 7 Cheatsheet: Email Forensics

## Objective
Identify sender/recipient metadata, message routing, and attachments from email evidence.

## Tools
- Windows: FTK Imager, Autopsy
- Kali: mailx, grep/awk, munpack
- Input: .eml, .msg, .pst, or .mbox files

## Windows Steps (FTK Imager)
1. Add email folder as evidence item.
2. Open .eml/.msg in Text or Hex view.
3. Extract header lines such as:
   - Delivered-To
   - Received
   - Return-Path
4. Preserve raw header text for reporting.

## Windows Steps (Autopsy)
1. Create case and add .pst/.mbox source.
2. Run Email Parser ingest module.
3. Review sender, recipient, timestamp, and subject metadata.
4. Export attachments and hash them.

## Kali Steps
1. Open mailbox interactively:
```bash
mail -f suspect_mailbox.mbox
```
2. Extract routing hosts from Received headers:
```bash
grep "Received: from" suspect_mailbox.mbox | awk '{print $4}' | sort | uniq -c
```
3. Install munpack and extract MIME attachments:
```bash
sudo apt install mpack
munpack suspect_email.eml
```

## Report Checklist
1. Sender and recipient identities
2. Full Received chain
3. Attachment names and hashes
4. Suspicious domains or relay hosts

## Critical Notes
- Preserve original raw message files.
- Large mbox files are often easier to parse via CLI.
