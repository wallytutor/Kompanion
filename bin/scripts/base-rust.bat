@REM For Rust these represent the path to the toolchain instead!
@REM No need do configure with version here!
@REM set RUST_DIR=rust
set RUST_DIR=rust-1.85.1-x86_64-pc-windows-gnu
set RUST_HOME=%KOMPANION_APPS%\%RUST_DIR%

@REM Configure required Rust variables.
set RUSTC_HOME=%RUST_HOME%\rustc
set CARGO_HOME=%RUST_HOME%\cargo
set RUST_PATH=%CARGO_HOME%\bin

@REM @REM Add to path:
set PATH=%RUST_PATH%;%RUSTC_HOME%\bin;%PATH%
