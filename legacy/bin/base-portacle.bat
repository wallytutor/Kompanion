@REM Configure version (the name of directory under apps/):
set PORTACLE_DIR=portacle

@REM Path to quicklisp package manager:
set QUICKLISP_HOME=%KOMPANION_APPS%\%PORTACLE_DIR%\all\quicklisp

@REM Path to executables root:
set PORTACLE_HOME=%KOMPANION_APPS%\%PORTACLE_DIR%\win

@REM Add to path:
set PATH=%PORTACLE_HOME%\lib;%PORTACLE_HOME%\bin;%PATH%