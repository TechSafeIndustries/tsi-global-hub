# VERIFY INDUSTRY PAGES - ENCODING AUDIT
# Scans all 7 industry pages for mojibake patterns
# Run after: .\fix-corrupted-industries.ps1

$ErrorActionPreference = "Stop"

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "INDUSTRY PAGES VERIFICATION" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# All 7 industry pages
$files = @(
    ".\industries\aviation\index.html",
    ".\industries\construction\index.html",
    ".\industries\energy-renewables\index.html",
    ".\industries\manufacturing\index.html",
    ".\industries\mining\index.html",
    ".\industries\oil-gas\index.html",
    ".\industries\transport-logistics\index.html"
)

# Mojibake patterns to detect
$badPatterns = @(
    "â€™",  # Bad apostrophe
    "â€"",  # Bad em dash
    "â€"",  # Bad en dash  
    "â€œ",  # Bad left quote
    "â€�",  # Bad right quote
    "â€¢",  # Bad bullet
    "Â©",   # Bad copyright
    "Ã",    # Bad character prefix
    "@{ bad" # PowerShell injection remnant
)

$totalIssues = 0
$cleanFiles = 0
$results = @()

foreach ($file in $files) {
    if (-not (Test-Path $file)) {
        Write-Host "⚠️  Not found: $file" -ForegroundColor Yellow
        continue
    }
    
    $content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)
    $issues = @()
    
    foreach ($pattern in $badPatterns) {
        if ($content.Contains($pattern)) {
            $count = ([regex]::Matches($content, [regex]::Escape($pattern))).Count
            $issues += "$pattern ($count)"
        }
    }
    
    $fileName = Split-Path $file -Leaf
    $industry = (Split-Path (Split-Path $file -Parent) -Leaf)
    
    if ($issues.Count -eq 0) {
        Write-Host "✅ $industry - CLEAN" -ForegroundColor Green
        $cleanFiles++
        $results += [PSCustomObject]@{
            Industry = $industry
            Status   = "PASS"
            Issues   = ""
        }
    }
    else {
        Write-Host "❌ $industry - ISSUES FOUND:" -ForegroundColor Red
        foreach ($issue in $issues) {
            Write-Host "   - $issue" -ForegroundColor Yellow
        }
        $totalIssues += $issues.Count
        $results += [PSCustomObject]@{
            Industry = $industry
            Status   = "FAIL"
            Issues   = ($issues -join ", ")
        }
    }
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "VERIFICATION SUMMARY" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Total files scanned: $($files.Count)" -ForegroundColor White
Write-Host "Clean files: $cleanFiles" -ForegroundColor Green
Write-Host "Files with issues: $($files.Count - $cleanFiles)" -ForegroundColor $(if ($totalIssues -gt 0) { "Red" } else { "Green" })
Write-Host "Total issues found: $totalIssues" -ForegroundColor $(if ($totalIssues -gt 0) { "Red" } else { "Green" })

if ($totalIssues -eq 0) {
    Write-Host "`n🎉 ALL INDUSTRY PAGES CLEAN!" -ForegroundColor Green
    Write-Host "========================================`n" -ForegroundColor Cyan
}
else {
    Write-Host "`n⚠️  ISSUES REMAIN - Review output above" -ForegroundColor Yellow
    Write-Host "========================================`n" -ForegroundColor Cyan
}

# Export results
$results | Format-Table -AutoSize
