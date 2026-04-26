@echo off
setlocal EnableExtensions

set "ROOT=%~dp0"
set "DIST=%ROOT%dist"
set "RUNTIME=%ROOT%dist\PDFChatApp"
set "TEMP_ENV=%TEMP%\ai-pdf-analyser-env-%RANDOM%.tmp"

if /i "%~1"=="create" goto CREATE_ENV
if /i "%~1"=="update" goto CREATE_ENV
if /i "%~1"=="delete" goto DELETE_ENV
if /i "%~1"=="remove" goto DELETE_ENV
if /i "%~1"=="show" goto SHOW_ENV

:MENU
cls
echo AI PDF Analyzer Full .env Manager
echo.
echo 1. Create or replace entire .env
echo 2. Delete all .env files
echo 3. Show current root .env
echo 4. Exit
echo.
set /p CHOICE=Choose an option: 
if "%CHOICE%"=="1" goto CREATE_ENV
if "%CHOICE%"=="2" goto DELETE_ENV
if "%CHOICE%"=="3" goto SHOW_ENV
if "%CHOICE%"=="4" exit /b 0
goto MENU

:CREATE_ENV
if exist "%TEMP_ENV%" del /f /q "%TEMP_ENV%" >nul 2>&1
echo.
echo Enter your full .env content one line at a time.
echo Example: GEMINI_API_KEY=your_key_here
echo Press Enter on an empty line when finished.
echo.

:READ_LINE
set "ENV_LINE="
set /p ENV_LINE=.env^> 
if "%ENV_LINE%"=="" goto SAVE_ENV
>>"%TEMP_ENV%" echo %ENV_LINE%
goto READ_LINE

:SAVE_ENV
if not exist "%TEMP_ENV%" (
  echo.
  echo No lines were entered. Nothing was created.
  goto DONE
)
copy /y "%TEMP_ENV%" "%ROOT%.env" >nul
if exist "%DIST%" copy /y "%TEMP_ENV%" "%DIST%\.env" >nul
if exist "%RUNTIME%" copy /y "%TEMP_ENV%" "%RUNTIME%\.env" >nul
del /f /q "%TEMP_ENV%" >nul 2>&1
echo.
echo Full .env created or replaced in available app locations.
goto DONE

:DELETE_ENV
if exist "%ROOT%.env" del /f /q "%ROOT%.env" >nul 2>&1
if exist "%DIST%\.env" del /f /q "%DIST%\.env" >nul 2>&1
if exist "%RUNTIME%\.env" del /f /q "%RUNTIME%\.env" >nul 2>&1
reg delete HKCU\Environment /v GEMINI_API_KEY /f >nul 2>&1
reg delete HKCU\Environment /v GOOGLE_API_KEY /f >nul 2>&1
echo.
echo All project .env files deleted.
goto DONE

:SHOW_ENV
echo.
if exist "%ROOT%.env" (
  echo Current root .env:
  echo ------------------
  type "%ROOT%.env"
  echo ------------------
) else (
  echo No root .env exists.
)
goto DONE

:DONE
echo.
pause
exit /b 0
