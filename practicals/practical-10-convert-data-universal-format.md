# Practical 10: Convert Data into a Universal Format

## Aim
Normalize Unix epoch timestamps into human-readable format using AWK.

## Part 1: Normalize applicationX log file

1. Open terminal in CyberOps Workstation VM and move to lab directory.

```bash
cd /home/analyst/lab.support.files/
ls -l
```

2. Convert epoch timestamp field (third field) and print output.

```bash
awk 'BEGIN {FS=OFS="|"} {$3=strftime("%c",$3)} {print}' applicationX_in_epoch.log
```

3. If needed, remove extra empty line from file using editor.

```bash
nano applicationX_in_epoch.log
```

4. Save normalized output to a new file.

```bash
awk 'BEGIN {FS=OFS="|"} {$3=strftime("%c",$3)} {print}' applicationX_in_epoch.log > applicationX_in_human.log
cat applicationX_in_human.log
```

## Part 2: Normalize Apache log file

1. Review Apache epoch log file.

```bash
cat apache_in_epoch.log
```

2. Run initial conversion and inspect output.

```bash
awk 'BEGIN {FS=OFS=" "} {$4=strftime("%c",$4)} {print}' apache_in_epoch.log
```

3. Fix bracket issue in timestamp field before conversion.

```bash
awk 'BEGIN {FS=OFS=" "} {gsub(/\[/,"",$4); gsub(/\]/,"",$4); $4=strftime("%c",$4)} {print}' apache_in_epoch.log
```

## Expected Result
- applicationX and Apache logs show readable date-time values instead of raw epoch values.
