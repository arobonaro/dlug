@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
(
echo [
for %%f in (*.mp3) do (
    set "name=%%~nf"

    rem Jeśli nazwa zaczyna się od dwóch cyfr i spacji, usuń je
    set "clean=!name!"
    for /f "tokens=1,2 delims= " %%a in ("!name!") do (
        echo %%a | findstr "^[0-9][0-9]$" >nul
        if not errorlevel 1 (
            set "clean=%%b"
        )
    )

    rem Na wszelki wypadek usuń tylko pierwsze 3 znaki jeśli są cyframi/spacjami
    if "!clean!"=="!name!" (
        set "first3=!name:~0,3!"
        echo !first3! | findstr "^[0-9][0-9] " >nul
        if not errorlevel 1 set "clean=!name:~3!"
    )

    echo     { "title": "!clean!", "src": "songs/%%f" },
)
echo ]
) > songs.json

echo ✅ Utworzono plik songs.json (UTF-8, bez numerków z przodu)
pause
