$ErrorActionPreference = "SilentlyContinue"
$port = 8002
$bind = "127.0.0.1"

# Find process listening on the specified port
$portPid = (Get-NetTCPConnection -LocalAddress $bind -LocalPort $port -State Listen -ErrorAction SilentlyContinue).OwningProcess

if ($portPid) {
  Write-Host "Stopped PID $portPid on $bind`:$port" -ForegroundColor Yellow
  Stop-Process -Id $portPid -Force -ErrorAction SilentlyContinue
  Start-Sleep -Milliseconds 500
} else {
  Write-Host "No listener found on $bind`:$port" -ForegroundColor Gray
}
