@REM Configure version (the name of directory under apps/):
set ELMER_DIR=ElmerFEM-gui-mpi-Windows-AMD64

@REM Path to executables root:
set ELMER_HOME=%KOMPANION_APPS%\%ELMER_DIR%

@REM Set environment variables:
set ELMERGUI_HOME=%ELMER_HOME%\share\ElmerGUI

@REM Add to path:
set PATH=%ELMER_HOME%\lib;%ELMER_HOME%\bin;%PATH%
