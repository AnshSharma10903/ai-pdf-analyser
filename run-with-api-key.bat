@echo off
setlocal EnableExtensions

set "ROOT=%~dp0"
set "DIST=%ROOT%dist"
set "APP_EXE=%DIST%\PDFChatApp.exe"

if not exist "%APP_EXE%" (
  echo Could not find: %APP_EXE%
  pause
  exit /b 1
)

echo AI PDF Analyzer
echo.
set "ENTERED_KEY="
set /p ENTERED_KEY=Enter Gemini API key, or press Enter to start without one: 

if "%ENTERED_KEY%"=="" goto START_WITHOUT_KEY

echo.
echo Checking API key with Google Gemini...
set "CANDIDATE_GEMINI_KEY=%ENTERED_KEY%"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$key=$env:CANDIDATE_GEMINI_KEY; try { $uri='https://generativelanguage.googleapis.com/v1beta/models?key=' + [uri]::EscapeDataString($key); $response=Invoke-RestMethod -Uri $uri -Method Get -TimeoutSec 20; if(@($response.models).Count -gt 0){ exit 0 } else { exit 1 } } catch { exit 1 }"
if errorlevel 1 goto START_WITHOUT_KEY

set "GEMINI_API_KEY=%ENTERED_KEY%"
set "GOOGLE_API_KEY=%ENTERED_KEY%"
set "ENTERED_KEY="
set "CANDIDATE_GEMINI_KEY="

echo API key accepted. Starting app with API access...
cd /d "%DIST%"
start "AI PDF Analyzer" "PDFChatApp.exe"
goto DONE

:START_WITHOUT_KEY
set "GEMINI_API_KEY="
set "GOOGLE_API_KEY="
set "ENTERED_KEY="
set "CANDIDATE_GEMINI_KEY="
call :REMOVE_LOCAL_ENV "%ROOT%.env"
call :REMOVE_LOCAL_ENV "%DIST%\.env"
call :REMOVE_LOCAL_ENV "%DIST%\PDFChatApp\.env"
echo.
echo No valid API key was provided. Starting app without API access.
echo The app may show a missing API key message when you ask AI questions.
cd /d "%DIST%"
start "AI PDF Analyzer" "PDFChatApp.exe"
goto DONE

:REMOVE_LOCAL_ENV
set "TARGET_ENV=%~1"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$path=$env:TARGET_ENV; if(Test-Path -LiteralPath $path){ $lines=Get-Content -LiteralPath $path | Where-Object { $_ -notmatch '^(GEMINI_API_KEY|GOOGLE_API_KEY)=' }; if($lines.Count -gt 0){ Set-Content -LiteralPath $path -Value $lines -Encoding ASCII } else { Remove-Item -LiteralPath $path -Force } }"
exit /b 0

:DONE
echo.
pause
exit /b 0
