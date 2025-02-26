@REM Configure version (the name of directory under apps/):
set NEOVIM_DIR=nvim-win64

@REM Path to executables root:
set NEOVIM_HOME=%KOMPANION_APPS%\%NEOVIM_DIR%

@REM Add to path:
set PATH=%NEOVIM_HOME%\lib;%NEOVIM_HOME%\bin;%PATH%