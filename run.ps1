$ErrorActionPreference = "Stop"
Set-Location -Path $PSScriptRoot

$port = 8002
$bind = "127.0.0.1"

# Kill anything already holding the port
${listenerPid} = (Get-NetTCPConnection -LocalAddress $bind -LocalPort $port -State Listen -ErrorAction SilentlyContinue).OwningProcess
if (${listenerPid}) {
  Write-Host "Killing existing listener on $bind`:$port (PID ${listenerPid})..." -ForegroundColor Yellow
  Stop-Process -Id ${listenerPid} -Force
}

Write-Host "Starting TSI local server on http://$bind`:$port/" -ForegroundColor Green
python -m http.server $port --bind $bind
