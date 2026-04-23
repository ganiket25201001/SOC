# Practical 2 Cheatsheet: Data Carving and Recovery

## Objective
Recover deleted or hidden files from unallocated space using at least three tools.

## Tools
- Windows: Autopsy, FTK Imager
- Kali: Scalpel
- Input: Forensic image from Practical 1 (.E01 or .dd)

## Windows Steps (Autopsy)
1. Create a new case (example: PRAC_02_CARVING).
2. Add the forensic image as data source.
3. Enable ingest modules: File Recovery and PhotoRec Carver.
4. Run ingest and wait for completion.
5. Open Views > File Types > Deleted Files.
6. Validate recovered files with hex view (header/footer check).

## Windows Steps (FTK Imager)
1. Add evidence item (image file).
2. Browse deleted entries (red X) and unallocated space.
3. Export candidate files for analysis.

## Kali Steps (Scalpel)
1. Configure file signatures:
```bash
sudo nano /etc/scalpel/scalpel.conf
```
2. Uncomment only required file types (jpg, png, pdf, doc, etc.).
3. Run carving:
```bash
sudo scalpel -o /home/kali/Desktop/recovered_data/ /home/kali/Desktop/evidence.dd
```
4. Review recovered_data/audit.txt for offsets and extraction details.

## Report Checklist
1. Tool used per recovered file
2. File path and type
3. Carving offset from audit logs
4. Validation notes (header/footer match)

## Critical Notes
- Keep output directory empty/new for Scalpel.
- Autopsy is stronger for deep carving than FTK quick export.
