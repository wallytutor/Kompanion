@REM Configure version (the name of directory under apps/):
set PARAVIEW_DIR=ParaView-5.13.2-MPI-Windows-Python3.10-msvc2017-AMD64

@REM Path to executables root:
set PARAVIEW_HOME=%KOMPANION_APPS%\%PARAVIEW_DIR%

@REM Add to path:
set PATH=%PARAVIEW_HOME%\bin;%PATH%
