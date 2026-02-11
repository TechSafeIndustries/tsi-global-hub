# FIX MOJIBAKE SCRIPT
# Fixes UTF-8 mojibake across HTML files

$ErrorActionPreference = "Stop"
Set-Location -Path $PSScriptRoot

# Define mojibake patterns and their correct replacements
$replacements = @{
    ' " } # â€�' = ' —'
    '†'''        = '→'
}

# Find all affected HTML files
$affectedFiles = @(
    "script.js",
    "industries\renewables\index.html",
    "industries\oil-gas\index.html",
    "industries\manufacturing\index.html",
    "industries\energy-renewables\index.html",
    "industries\construction\index.html",
    "assessment\TSI Leadership Matrix\leadership.html",
    "about\leadership.html"
)

$fixCount = 0

foreach ($file in $affectedFiles) {
    $fullPath = Join-Path $PSScriptRoot $file
    
    if (Test-Path $fullPath) {
        Write-Host "Fixing: $file" -ForegroundColor Cyan
        
        # Read file content as UTF-8
        $content = Get-Content $fullPath -Raw -Encoding UTF8
        
        # Apply replacements
        foreach ($bad in $replacements.Keys) {
            $good = $replacements[$bad]
            if ($content -match [regex]::Escape($bad)) {
                $content = $content -replace [regex]::Escape($bad), $good
                $fixCount++
            }
        }
        
        # Save back as UTF-8 without BOM
        $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
        [System.IO.File]::WriteAllText($fullPath, $content, $utf8NoBom)
        
        Write-Host "  ✓ Fixed" -ForegroundColor Green
    }
    else {
        Write-Host "  ✗ File not found" -ForegroundColor Red
    }
}

Write-Host "`nTotal replacements made: $fixCount" -ForegroundColor Yellow
