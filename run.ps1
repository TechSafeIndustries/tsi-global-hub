$ErrorActionPreference = "Stop"
Set-Location -Path $PSScriptRoot

$port = 8002
$bind = "127.0.0.1"

# Call stop.ps1 to ensure port is free
Write-Host "Ensuring port is free..." -ForegroundColor Cyan
& "$PSScriptRoot\stop.ps1"

Write-Host "Starting TSI local server on http://$bind`:$port/" -ForegroundColor Green
Start-Process python -ArgumentList "-m", "http.server", "$port", "--bind", "$bind" -NoNewWindow -PassThru | Out-Null

# Wait for server to start
Start-Sleep -Milliseconds 1500

# Verify server is responding
try {
  $response = Invoke-WebRequest -Uri "http://$bind`:$port/" -UseBasicParsing -TimeoutSec 3
  if ($response.StatusCode -eq 200) {
    Write-Host "Server verified: HTTP 200 OK" -ForegroundColor Green
  }
} catch {
  Write-Host "Server verification FAILED: Unable to connect" -ForegroundColor Red
}

Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Yellow
Wait-Process -Name python -ErrorAction SilentlyContinue
