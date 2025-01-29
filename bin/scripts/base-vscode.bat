@REM Configure version (name of directory under apps/):
set VSCODE_DIR=VSCode-win32-x64-1.96.4

@REM Configure Visual Studio Code shared settings:
set VSCODE_EXTENSIONS=%KOMPANION_ROOT%vscode\extensions
set VSCODE_SETTINGS=%KOMPANION_ROOT%vscode\user-data

@REM Add to path:
set PATH=%KOMPANION_ROOT%apps\%VSCODE_DIR%;%PATH%