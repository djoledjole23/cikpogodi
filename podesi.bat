@echo off
title Cik Pogodi - podesavanja
cd /d "%~dp0"
if not exist ".env.local" copy ".env.example" ".env.local" >nul
echo.
echo  Otvaram fajl sa podesavanjima u Notepad-u.
echo  Popuni prazna polja, pa pritisni Ctrl+S da sacuvas.
echo  Kad zavrsis, zatvori Notepad i pokreni pokreni.bat
echo.
notepad ".env.local"
