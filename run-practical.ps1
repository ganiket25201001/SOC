param(
    [int]$Number,
    [switch]$All,
    [switch]$List,
    [switch]$Open
)

$practicals = [ordered]@{
    "1"  = "practicals/practical-01-openssl.md"
    "2"  = "practicals/practical-02-snort-firewall.md"
    "3"  = "practicals/practical-03-extract-exe-from-pcap.md"
    "4"  = "practicals/practical-04-dns-traffic-analysis.md"
    "5"  = "practicals/practical-05-rsyslog-server.md"
    "6"  = "practicals/practical-06-forward-logs-to-syslog.md"
    "7"  = "practicals/practical-07-install-splunk-linux.md"
    "8"  = "practicals/practical-08-install-elk-linux.md"
    "9"  = "practicals/practical-09-install-graylog-linux.md"
    "10" = "practicals/practical-10-convert-data-universal-format.md"
}

function Show-File {
    param(
        [string]$RelativePath,
        [switch]$OpenFile
    )

    $fullPath = Join-Path $PSScriptRoot $RelativePath
    if (-not (Test-Path $fullPath)) {
        Write-Error "File not found: $fullPath"
        return
    }

    Write-Host "`n==== $RelativePath ====" -ForegroundColor Cyan

    if ($OpenFile) {
        Start-Process $fullPath
    } else {
        Get-Content -Path $fullPath
    }
}

if ($List -or (-not $All -and -not $Number)) {
    Write-Host "Available Practicals:" -ForegroundColor Yellow
    foreach ($key in $practicals.Keys) {
        Write-Host ("{0,2}: {1}" -f $key, $practicals[$key])
    }
    Write-Host "`nUse -Number <1-10>, -All, and optional -Open" -ForegroundColor Yellow
    exit 0
}

if ($All) {
    foreach ($key in $practicals.Keys) {
        Show-File -RelativePath $practicals[$key] -OpenFile:$Open
    }
    exit 0
}

if ($Number) {
    $numberKey = [string]$Number

    if (-not $practicals.Contains($numberKey)) {
        Write-Error "Invalid practical number: $Number. Use values 1 to 10."
        exit 1
    }

    Show-File -RelativePath $practicals[$numberKey] -OpenFile:$Open
    exit 0
}
