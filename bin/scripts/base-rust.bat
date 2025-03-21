@REM Configure version (the name of directory under apps/):
set RUST_DIR=rust-stable-gnu-1.85

@REM Path to executables root:
set RUST_HOME=%KOMPANION_APPS%\%RUST_DIR%

@REM Add to path:
set PATH=%RUST_HOME%\bin;%PATH%
set PATH=%RUST_HOME%\lib;%PATH%

@REM set RUST_LIB=%RUST_HOME%\lib\rustlib\x86_64-pc-windows-gnu
@REM set PATH=%RUST_LIB%\bin;%PATH%
@REM set PATH=%RUST_LIB%\lib;%PATH%
