# Adding languages

1. Go to Julia [download page](https://julialang.org/downloads/) and select the latest stable Windows 64-bit portable version. Move the file to `downloads` and extract it, then move the resulting folder to `apps`. You might need to edit `scripts/base-julia.bat`. Notice that in this file it is not the extracted directory name that must be provided, but Julia semantic version.

2. Go to WinPython [download page](https://github.com/winpython/winpython/releases) and find the latest version taged with a *Latest* green flag (avoir *Pre-release* versions on top). Expand the *Assets* and download the `.exe` version (also a disguised compressed file). Follow steps similar to Git above, but notice that WinPython will extract directly to `downloads`. After moving the directory to `apps`, set the directory variable in `scripts/base-python.bat`.

3. Go to Octave [download page](https://octave.org/download) and identify the `.zip` package for `w64`. Proceed with edition of `scripts/base-octave.bat` as you have done so far.

4. Go to Ruby [download page](https://rubyinstaller.org/downloads/) and identify the `Devkit` package for `x64`. During installation change the path to point to `apps/` and unselect the options to associate extensions and adding to the path. Proceed with edition of `scripts/base-octave.bat` as you have done so far.

5. Download the [static GNU Rust](https://static.rust-lang.org/dist/rust-1.85.1-x86_64-pc-windows-gnu.tar.xz) and extract the tar-ball.

Alnterativelly download [GNU suite of Rusupt](https://static.rust-lang.org/rustup/dist/x86_64-pc-windows-gnu/rustup-init.exe). Because it requires a preset of environment variables, run it from a Kompanion VS Code terminal. During installation chose to `2) Customize installation` and make sure to get the following setup

```text
   default host triple: x86_64-pc-windows-gnu
     default toolchain: stable (default)
               profile: complete
  modify PATH variable: no
```

It is strongly recommended to install [Quarto](https://quarto.org/docs/download/) as a supporting tool for publishing reports from Julia and Python. Please notice that Jupyter environment handled automatically by Python post-installation. Upon the first time you launch Julia, it will globally install IJulia and Pluto for the same end.
