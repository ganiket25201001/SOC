# Practical 8: Study internet artifact analysis to examine web browsing history, chat logs, and other internet artifacts to identify user activity using Browser History Examiner and ChromeCacheViewer

## Content

Aim: To reconstruct browsing history and cache.
Prerequisites: Browser History Examiner, ChromeCacheViewer.
Implementation 1: Windows Environment
Tool A: Browser History Examiner
Launch: Run the tool. If you are analyzing the forensic image, point it to the drive letter where the image is mounted
Select Artifacts: Choose Chrome, Firefox, or Edge.
Analyze: The tool will parse the SQLite databases and present a unified timeline. Look for "Search Terms"—this tells you exactly what the user was looking for on Google or Bing.
Report: Export the filtered results to a CSV or PDF.
Tool B: ChromeCacheViewer (NirSoft)
Locate Cache: Go to File -> Select Cache Folder.
Point to Evidence: Navigate to the extracted folder: [User_Profile]\AppData\Local\Google\Chrome\User Data\Default\Cache.
Reconstruct: The tool lists all cached items. Sort by "Last Accessed."
View: Double-click an entry to see the URL. If it’s an image, use the "Open Cache Subfolder" to see the actual file the user saw on their screen.
Implementation 2: Kali Linux Environment
Tool Used: sqlite3 (The professional way)
Professor's Note: Tools like Browser History Examiner are just GUIs for SQL queries. A real investigator knows how to talk to the database directly.
Step-by-Step Procedure:
Locate the Database: Navigate to the extracted browser folder in your terminal.
Access History: ```bash
sqlite3 History
Query the Data: Run a SQL command to see URLs and Visit Times:
SELECT url, title, visit_count, last_visit_time FROM urls ORDER BY last_visit_time DESC;
Note: Chrome timestamps are in "WebKit format" (microseconds since Jan 1, 1601). You’ll need to convert these to human-readable time.
Extract Strings from Cache: If the cache is corrupted or in a proprietary format:
strings Chrome_Cache_File | grep -i "http" | less
This pulls every URL string out of the raw cache data.



