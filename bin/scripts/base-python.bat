@REM Configure version (the name of directory under apps/):
set PYTHON_DIR=WPy64-31310

@REM Path to Python executables root:
set PYTHON_HOME=%KOMPANION_APPS%\%PYTHON_DIR%\python

@REM Add to path:
set PATH=%PYTHON_HOME%;%PYTHON_HOME%\Scripts;%PATH%

@REM Add modules to path:
set PATH=%KOMPANION_PKGS%\Taskforce.jl\src\py;%PATH%
set PYTHONPATH=%KOMPANION_PKGS%\Taskforce.jl\src\py;%PYTHONPATH%