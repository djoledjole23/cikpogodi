@echo off
setlocal
title Cik Pogodi - lokalno pokretanje
cd /d "%~dp0"

echo.
echo  ===  Cik Pogodi: pokretanje na ovom racunaru  ===
echo.

rem --- 1) Node.js ---
where node >nul 2>nul
if not errorlevel 1 goto imanode
if exist "%ProgramFiles%\nodejs\node.exe" goto dodajputanju

echo Node.js nije instaliran. Instaliram zvanicnu LTS verziju (winget, paket OpenJS.NodeJS.LTS).
echo Ako Windows pita za dozvolu, klikni Yes.
echo.
winget install -e --id OpenJS.NodeJS.LTS --accept-package-agreements --accept-source-agreements
if not exist "%ProgramFiles%\nodejs\node.exe" goto nemanode

:dodajputanju
set "PATH=%ProgramFiles%\nodejs;%PATH%"

:imanode
for /f "delims=" %%v in ('node -v') do echo Node.js: %%v

rem --- 2) Paketi (samo prvi put ili posle nove verzije) ---
if exist "node_modules\next\package.json" if exist "node_modules\postgres\package.json" goto pokreni
echo.
echo Instaliram pakete. Prvi put traje minut-dva...
call npm install
if errorlevel 1 goto greska

:pokreni
echo.
echo Pokrecem sajt. Za nekoliko sekundi otvorice se http://localhost:3000
echo Ovaj prozor mora da ostane otvoren dok testiras. Gasi se sa Ctrl+C ili zatvaranjem prozora.
echo.
start "" /min cmd /c "timeout /t 8 /nobreak >nul & start http://localhost:3000"
rem Proba na ovom racunaru: rang lista sa izmisljenim igracima, da se vidi kako izgleda.
set CP_PROBNA_LISTA=1
call npm run dev
goto kraj

:nemanode
echo.
echo Node.js nije instaliran automatski.
echo Skini ga rucno sa https://nodejs.org (dugme LTS), instaliraj, pa ponovo pokreni ovaj fajl.
goto kraj

:greska
echo.
echo Instalacija paketa nije uspela. Posalji sliku ovog prozora.

:kraj
echo.
pause
