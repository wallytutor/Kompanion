@REM Configure version (the name of directory under apps/):
set GMSH_DIR=gmsh-4.13.1-Windows64-sdk

@REM Path to executables root:
set GMSH_HOME=%KOMPANION_APPS%\%GMSH_DIR%

@REM Add to path:
set PATH=%GMSH_HOME%\bin;%GMSH_HOME%\lib;%PATH%
