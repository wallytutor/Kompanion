@REM Configure version (the name of directory under apps/):
set OCTAVE_DIR=octave-9.3.0-w64

@REM Path to Python executables root:
set OCTAVE_HOME=%KOMPANION_APPS%\%OCTAVE_DIR%

@REM Add to path:
set PATH=%OCTAVE_HOME%;%OCTAVE_HOME%\mingw64\bin;%PATH%
