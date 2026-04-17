# Practical 10: Convert Data into a Universal Format

## Aim
Normalize Unix epoch timestamps into human-readable format using AWK.

## Part 1: Normalize `applicationX` Log File

1. Move to lab files directory.

```bash
cd /home/analyst/lab.support.files/
```

2. Verify `applicationX_in_epoch.log` is present.

```bash
ls -l applicationX_in_epoch.log
```

3. Verify `apache_in_epoch.log` is present.

```bash
ls -l apache_in_epoch.log
```

4. Convert third field (epoch timestamp) and print result.

```bash
awk 'BEGIN {FS=OFS="|"} {$3=strftime("%c",$3)} {print}' applicationX_in_epoch.log
```

5. Save normalized output to a new file.

```bash
awk 'BEGIN {FS=OFS="|"} {$3=strftime("%c",$3)} {print}' applicationX_in_epoch.log > applicationX_in_human.log
```

6. Display the normalized `applicationX` output file.

```bash
cat applicationX_in_human.log
```

## Part 2: Normalize Apache Log File

1. Review original Apache log file.

```bash
cat apache_in_epoch.log
```

2. Run initial conversion attempt.

```bash
awk 'BEGIN {FS=OFS=" "} {$4=strftime("%c",$4)} {print}' apache_in_epoch.log
```

3. Fix square bracket issue in timestamp field and save output.

```bash
awk 'BEGIN {FS=OFS=" "} {gsub(/\[/,"",$4); gsub(/\]/,"",$4); $4=strftime("%c",$4)} {print}' apache_in_epoch.log > apache_in_human.log
```

4. Display normalized Apache output file.

```bash
cat apache_in_human.log
```

## Expected Result
- `applicationX_in_human.log` shows readable timestamps.
- `apache_in_human.log` shows corrected readable timestamps after bracket cleanup.
