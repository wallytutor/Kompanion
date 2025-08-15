# Programming languages

The following provides instructions for some languages you might wish to have fully integrated to your environment. For lower level languages, please consider using MSYS2 as described in its dedicated section.

It is strongly recommended to install [Quarto](https://quarto.org/docs/download/) as a supporting tool for publishing reports from Julia and Python. Please notice that Jupyter environment handled automatically by Python post-installation. Upon the first time you launch Julia, it will globally install IJulia and Pluto for the same end.

**Warning:** for now having both Rust and Octave fully operational in command-line is not working. This should not be a problem as Octave can be launched with its user-interface and that remain the most popular/recommended way of using it.

**Warning:** For a fully operational *Jupyter notebook* environment, other the LaTeX support discussed in its dedicatet section, you also need both `pandoc` and `inkscape`.

## Julia

Go to Julia [download page](https://julialang.org/downloads/) and select the latest stable Windows 64-bit portable version. Move the file to `downloads` and extract it, then move the resulting folder to `apps`. You might need to edit `scripts/base-julia.bat`. Notice that in this file it is not the extracted directory name that must be provided, but Julia semantic version.

## Python

Go to WinPython [download page](https://github.com/winpython/winpython/releases) and find the latest version taged with a *Latest* green flag (avoir *Pre-release* versions on top). Expand the *Assets* and download the `.exe` version (also a disguised compressed file). Follow steps similar to Git above, but notice that WinPython will extract directly to `downloads`. After moving the directory to `apps`, set the directory variable in `scripts/base-python.bat`.

## Octave

Go to Octave [download page](https://octave.org/download) and identify the `.zip` package for `w64`. Proceed with edition of `scripts/base-octave.bat` as you have done so far.

## Ruby

Go to Ruby [download page](https://rubyinstaller.org/downloads/) and identify the `Devkit` package for `x64`. During installation change the path to point to `apps/` and unselect the options to associate extensions and adding to the path. Proceed with edition of `scripts/base-octave.bat` as you have done so far.

## Rust

To use Rust you must have followed the instllation instructions for [MSYS2](setup-general.md); package `mingw-w64-x86_64-binutils` must have been installed. Next, download the static GNU [Rust MSI installer](https://static.rust-lang.org/dist/rust-1.85.1-x86_64-pc-windows-gnu.msi) and execute it; chose advanced options to be able to select installation for the current user only. Select to install under `apps\rust-stable-gnu-1.85` directory. Check `base-rust.bat` for environment setup.
