@REM Configure version (name of directory under apps/):
set MIXTEX_DIR=miktex-portable
set JABREF_DIR=JabRef
set PANDOC_DIR=pandoc-3.6.2
set INKSCAPE_DIR=inkscape

@REM Path to MiKTeX executables root:
set MIKTEX_HOME=%KOMPANION_APPS%\%MIXTEX_DIR%

@REM Run MiKTeX console:
call %MIKTEX_HOME%\miktex-portable.cmd

@REM Add to path:
set PATH=%MIKTEX_HOME%\texmfs\install\miktex\bin\x64\internal;%PATH%
set PATH=%MIKTEX_HOME%\texmfs\install\miktex\bin\x64;%PATH%
set PATH=%KOMPANION_APPS%\%JABREF_DIR%\runtime\bin;%PATH%
set PATH=%KOMPANION_APPS%\%PANDOC_DIR%;%PATH%
set PATH=%KOMPANION_APPS%\%INKSCAPE_DIR%\bin;%PATH%
