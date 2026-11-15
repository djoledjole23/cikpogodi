@echo off
setlocal
title Cik Pogodi - azuriranje pitanja
cd /d "%~dp0"

echo.
echo  ===  Cik Pogodi: upis novih pitanja u bazu  ===
echo.

where node >nul 2>nul
if not errorlevel 1 goto imanode
if exist "%ProgramFiles%\nodejs\node.exe" (
  set "PATH=%ProgramFiles%\nodejs;%PATH%"
  goto imanode
)
echo Node.js nije instaliran. Prvo pokreni pokreni.bat, on ce ga instalirati.
goto kraj

:imanode
if exist "node_modules\postgres\package.json" goto radi
echo Instaliram pakete, prvi put traje minut-dva...
call npm install
if errorlevel 1 goto greska

:radi
node supabase\alati\azuriraj-pitanja.mjs
goto kraj

:greska
echo.
echo Instalacija paketa nije uspela. Posalji sliku ovog prozora.

:kraj
echo.
pause
