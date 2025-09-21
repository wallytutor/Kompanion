@echo off
call %~dp0activate.bat

Code.exe ^
    --extensions-dir=%VSCODE_EXTENSIONS% ^
    --user-data-dir=%VSCODE_SETTINGS% ^
    -r %KOMPANION_ROOT%..
