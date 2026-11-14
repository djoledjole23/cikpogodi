@echo off
title Cik Pogodi - podesavanja
cd /d "%~dp0"

if exist ".env.local" goto otvori
if exist "podesavanja-uzorak.txt" (copy "podesavanja-uzorak.txt" ".env.local" >nul) else (copy ".env.example" ".env.local" >nul)

:otvori
echo.
echo  Otvaram fajl sa podesavanjima u Notepad-u.
echo.
echo  1) Popuni prazna polja vrednostima iz Supabase-a
echo  2) Pritisni Ctrl+S da sacuvas
echo  3) Zatvori Notepad, pa pokreni pokreni.bat
echo.
notepad ".env.local"
