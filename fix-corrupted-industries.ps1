# FIX CORRUPTED INDUSTRY PAGES - ASCII SAFE
# All patterns defined using character codes

$files = @(
    ".\industries\manufacturing\index.html",
    ".\industries\energy-renewables\index.html",
    ".\industries\construction\index.html"
)

Write-Host ""
Write-Host "Processing files..."
Write-Host ""

$totalFixed = 0

foreach ($file in $files) {
    if (-not (Test-Path $file)) {
        continue
    }
    
    Write-Host "File: $file"
    
    $content = Get-Content $file -Raw -Encoding UTF8
    $original = $content
    
    # Fix PowerShell injection using regex
    $content = $content -replace '@\{ bad = \[Text\.Encoding\]::UTF8\.GetString\(\[byte\[\]\]\([^)]+\)\); good = [^\n]+ with human', 'with human'
    
    # Fix mojibake arrows using char codes
    $arrowBad = [char]0xC3 + [char]0xA2 + [char]0xE2 + [char]0x82 + [char]0xAC + ' ' + [char]0xC3 + [char]0xA2 + [char]0xE2 + [char]0x82 + [char]0xAC + [char]0xE2 + [char]0x84 + [char]0xA2
    $arrowGood = [char]0x2192
    $content = $content.Replace($arrowBad, $arrowGood)
    
    # Fix operations line
    $content = $content -replace 'operations[^\n]+\n\s+with human', ('operations ' + [char]0x2014 + "`n                    with human")
    
    if ($content -ne $original) {
        $utf8 = New-Object System.Text.UTF8Encoding($false)
        [System.IO.File]::WriteAllText($file, $content, $utf8)
        Write-Host "  FIXED" -ForegroundColor Green
        $totalFixed++
    }
    else {
        Write-Host "  OK" -ForegroundColor Gray
    }
}

Write-Host ""
Write-Host "Total fixed: $totalFixed"
Write-Host ""
