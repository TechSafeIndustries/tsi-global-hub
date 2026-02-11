# MOJIBAKE FIX SCRIPT FOR INDUSTRY PAGES
# Fixes UTF-8 encoding issues across industry landing pages

$ErrorActionPreference = "Stop"

# Files to fix
$files = @(
    ".\industries\oil-gas\index.html",
    ".\industries\manufacturing\index.html",
    ".\industries\energy-renewables\index.html",
    ".\industries\construction\index.html"
)

# Pattern replacements (mojibake → correct UTF-8)
$fixes = @(
    @{ Pattern = 'â€" ` @{ bad = \[Text\.Encoding\]::UTF8\.GetString\(\[byte\[\]\]\(0xC3,0xA2,0xE2,0x82,0xAC,0xE2,0x80,0x9C\)\); good = â€œ '; Replace = ' — ' },
    @{ Pattern = 'â€ â€™'; Replace = '→' },
    @{ Pattern = 'Â©'; Replace = '©' }
)

$totalFixes = 0

foreach ($file in $files) {
    if (Test-Path $file) {
        Write-Host "Processing: $file" -ForegroundColor Cyan
        
        # Read as UTF-8
        $content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)
        $fixCount = 0
        
        # Apply all fixes
        foreach ($fix in $fixes) {
            $before = $content
            $content = $content -replace [regex]::Escape($fix.Pattern), $fix.Replace
            if ($content -ne $before) {
                $count = ([regex]::Matches($before, [regex]::Escape($fix.Pattern))).Count
                Write-Host "  - Fixed: $($fix.Pattern) → $($fix.Replace) ($count occurrences)" -ForegroundColor Green
                $fixCount += $count
            }
        }
        
        # Save as UTF-8 without BOM
        $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
        [System.IO.File]::WriteAllText($file, $content, $utf8NoBom)
        
        $totalFixes += $fixCount
        Write-Host "  ✓ Total fixes: $fixCount" -ForegroundColor Yellow
    }
    else {
        Write-Host "  ✗ File not found: $file" -ForegroundColor Red
    }
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "TOTAL FIXES ACROSS ALL FILES: $totalFixes" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
