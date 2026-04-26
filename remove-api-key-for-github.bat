@echo off
setlocal EnableExtensions

set "ROOT=%~dp0"

echo Removing API keys from AI PDF Analyzer before GitHub upload...
echo.

call :REMOVE_ENV "%ROOT%.env"
call :REMOVE_ENV "%ROOT%dist\.env"
call :REMOVE_ENV "%ROOT%dist\PDFChatApp\.env"

reg delete HKCU\Environment /v GEMINI_API_KEY /f >nul 2>&1
reg delete HKCU\Environment /v GOOGLE_API_KEY /f >nul 2>&1

echo Checking project text files for Google API-key looking strings...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$root=$env:ROOT; $hits=Get-ChildItem -LiteralPath $root -Recurse -Force -File | Where-Object { $_.Length -lt 50000000 -and $_.FullName -notlike '*\.git\*' } | Select-String -Pattern 'AIza[0-9A-Za-z_-]+' -ErrorAction SilentlyContinue; if($hits){ $hits | ForEach-Object { Write-Host ($_.Path + ':' + $_.LineNumber + ' contains a Google API-key-looking value') }; exit 1 } else { Write-Host 'No Google API-key-looking values found in scanned files.' }"

echo.
echo Cleanup complete. Review the scan output above before uploading publicly.
pause
exit /b 0

:REMOVE_ENV
set "TARGET_ENV=%~1"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$path=$env:TARGET_ENV; if(Test-Path -LiteralPath $path){ $lines=Get-Content -LiteralPath $path | Where-Object { $_ -notmatch '^(GEMINI_API_KEY|GOOGLE_API_KEY)=' }; if($lines.Count -gt 0){ Set-Content -LiteralPath $path -Value $lines -Encoding ASCII } else { Remove-Item -LiteralPath $path -Force } }"
exit /b 0
