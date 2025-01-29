@REM Configure version (THIS IS NOT the name of directory under
@REM apps/, but the sub-directory under the extracted directory):
set JULIA_VERSION=julia-1.11.3

@REM Configure base directory (name of directory under apps/):
set JULIA_DIR=%KOMPANION_APPS%\%JULIA_VERSION%-win64

@REM Add to path:
set PATH=%JULIA_DIR%\%JULIA_VERSION%\bin;%PATH%

@REM Configure where Julia installs packages:
set JULIA_DEPOT_PATH=%JULIA_DIR%\depot

@REM Workaround for creating CondaPkg elsewhere
set JULIA_CONDAPKG_ENV=%JULIA_DIR%\CondaPkg
