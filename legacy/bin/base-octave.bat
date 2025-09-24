@REM Configure version (the name of directory under apps/):
set OCTAVE_DIR=octave-9.3.0-w64

@REM Path to executables root:
set OCTAVE_HOME=%KOMPANION_APPS%\%OCTAVE_DIR%

@REM Add to path:
set PATH=%OCTAVE_HOME%;%PATH%

@REM DO NOT ADD THIS FOR RUST TO WORK!
@REM set PATH=%OCTAVE_HOME%\mingw64\bin;%PATH%
@REM set PATH=%OCTAVE_HOME%\mingw64\lib;%PATH%