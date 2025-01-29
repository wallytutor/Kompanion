@REM @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@REM CONFIGURE ENVIRONMENT
@REM @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

@REM Main variable for configuration of the environment:
set KOMPANION_ROOT=%~dp0

@REM Path to where applications are installed:
set KOMPANION_APPS=%KOMPANION_ROOT%apps

@REM Path to where data is stored:
set KOMPANION_DATA=%KOMPANION_ROOT%data

@REM Some software may require a specific locale to be set:
set LANG="en_US.UTF-8"

@REM These may also contain launcher scripts/applications:
set PATH=%KOMPANION_ROOT%;%PATH%
set PATH=%KOMPANION_APPS%;%PATH%

@REM @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@REM BASE PACKAGES
@REM @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

call %KOMPANION_ROOT%scripts\base-vscode.bat
call %KOMPANION_ROOT%scripts\base-git.bat

@REM @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@REM ADDITIONAL PACKAGES
@REM @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

@REM @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@REM LANGUAGES (COME LAST TO OVERRIDE PREVIOUSLY FOUND INTERPRETERS)
@REM @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

call %KOMPANION_ROOT%scripts\base-julia.bat
call %KOMPANION_ROOT%scripts\base-python.bat

@REM Jupyter to be used with IJulia.
@REM set JUPYTER=%PYTHON_HOME%\Scripts\jupyter.exe
@REM set JUPYTER_DATA_DIR=%HERE%..\jupyter

@REM @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@REM EOF
@REM @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@