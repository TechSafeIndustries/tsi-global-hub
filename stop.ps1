$ErrorActionPreference = "SilentlyContinue"
$port = 8002
$bind = "127.0.0.1"
${listenerPid} = (Get-NetTCPConnection -LocalAddress $bind -LocalPort $port -State Listen).OwningProcess
if (${listenerPid}) {
  Write-Host "Stopping listener on $bind`:$port (PID ${listenerPid})..." -ForegroundColor Yellow
  Stop-Process -Id ${listenerPid} -Force
} else {
  Write-Host "No listener found on $bind`:$port" -ForegroundColor Gray
}
