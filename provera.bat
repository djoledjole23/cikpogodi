@echo off
title Cik Pogodi - provera podesavanja
cd /d "%~dp0"
where node >nul 2>nul
if errorlevel 1 set "PATH=%ProgramFiles%\nodejs;%PATH%"
node scripts\proveri-env.mjs
echo.
pause
