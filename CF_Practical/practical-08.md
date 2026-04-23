# Practical 8 Cheatsheet: Internet Artifact Analysis

## Objective
Reconstruct user web activity using browser history and cache artifacts.

## Tools
- Windows: Browser History Examiner, ChromeCacheViewer
- Kali: sqlite3, strings
- Input: Extracted browser profile artifacts

## Windows Steps (Browser History Examiner)
1. Load extracted browser profile or mounted evidence path.
2. Select target browsers (Chrome/Firefox/Edge).
3. Parse timeline and review search terms and visited URLs.
4. Export findings to CSV/PDF.

## Windows Steps (ChromeCacheViewer)
1. Open cache folder selection.
2. Point to Chrome cache path:
   - [User_Profile]\\AppData\\Local\\Google\\Chrome\\User Data\\Default\\Cache
3. Sort by Last Accessed.
4. Open entries to map cached objects to URLs.

## Kali Steps (sqlite3)
1. Open Chrome History database:
```bash
sqlite3 History
```
2. Query recent visits:
```sql
SELECT url, title, visit_count, last_visit_time FROM urls ORDER BY last_visit_time DESC;
```
3. If cache parsing is difficult, extract URL strings:
```bash
strings Chrome_Cache_File | grep -i "http" | less
```

## Report Checklist
1. Search terms and visited domains
2. Visit counts and sequence of activity
3. Cached files linked to user actions

## Critical Notes
- Convert WebKit timestamps to human-readable time before final reporting.
- Cache and history should be correlated for stronger conclusions.
