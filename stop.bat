@echo off
setlocal

set "ROOT=%~dp0"
cd /d "%ROOT%"

echo Stopping AI PDF Analyzer from: %ROOT%
echo.

if exist "server.pid" (
  set /p SERVER_PID=<server.pid
  if not "%SERVER_PID%"=="" (
    echo Stopping server PID %SERVER_PID%...
    taskkill /PID %SERVER_PID% /T /F >nul 2>&1
  )
)

echo Stopping packaged app processes...
taskkill /IM PDFChatApp.exe /T /F >nul 2>&1

echo Stopping Python/Node processes launched from this project...
set "AI_PDF_ANALYSER_ROOT=%ROOT%"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$root=$env:AI_PDF_ANALYSER_ROOT; $names=@('python.exe','pythonw.exe','flask.exe','node.exe','npm.exe','npx.exe'); Get-CimInstance Win32_Process | Where-Object { $names -contains $_.Name -and (($_.ExecutablePath -like ($root + '*')) -or ($_.CommandLine -like ('*' + $root + '*'))) } | ForEach-Object { Write-Host ('Stopping PID ' + $_.ProcessId + ' ' + $_.Name); Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue }" 2>nul

for /f "tokens=5" %%a in ('netstat -ano ^| findstr /R /C:":5000 .*LISTENING"') do (
  echo Stopping process using port 5000: %%a
  taskkill /PID %%a /T /F >nul 2>&1
)

if exist "server.pid" del /f /q "server.pid" >nul 2>&1

echo.
echo Done. You can try deleting or restarting ai-pdf-analyser-main now.
pause
