@REM Configure version (THIS IS NOT the name of directory under
@REM apps/, but the sub-directory under the extracted directory):
set JULIA_VERSION=julia-1.11.3

@REM Configure base directory (name of directory under apps/):
set JULIA_DIR=%JULIA_VERSION%-win64

@REM Julia home directory:
set JULIA_HOME=%KOMPANION_APPS%\%JULIA_DIR%

@REM Add to path:
set PATH=%JULIA_HOME%\%JULIA_VERSION%\bin;%PATH%

@REM Configure where Julia installs packages:
set JULIA_DEPOT_PATH=%KOMPANION_DATA%\julia-depot

@REM Workaround for creating CondaPkg elsewhere
set JULIA_CONDAPKG_ENV=%KOMPANION_DATA%\CondaPkg
