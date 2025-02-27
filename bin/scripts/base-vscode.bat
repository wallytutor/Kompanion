@REM Configure version (name of directory under apps/):
set VSCODE_DIR=VSCode-win32-x64-1.96.4

@REM Path to VSCode executables root:
set VSCODE_HOME=%KOMPANION_APPS%\%VSCODE_DIR%

@REM Configure Visual Studio Code shared settings:
set VSCODE_EXTENSIONS=%KOMPANION_DATA%\vscode\extensions
set VSCODE_SETTINGS=%KOMPANION_DATA%\vscode\user-data

@REM Add to path:
set PATH=%VSCODE_HOME%;%PATH%