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

## LaTeX and related

Although LaTeX is not mandatory, it is highly encouraged; otherwise, what is the point of doing any scientific computing and not publishing its results?

- Start by following the instructions provided [here](https://miktex.org/howto/portable-edition) to install MikTeX. Point the installation to a directory `miktex-portable` under `apps` and select *on-the-fly* installation of new packages.

- Consider installing the following additional software:

    - [JabRef](https://www.fosshub.com/JabRef.html)
    - [pandoc](https://github.com/jgm/pandoc/releases)
    - [inkscape](https://inkscape.org/release/1.4/windows/64-bit/)

- Globally install [`pip install Pygments`](https://pygments.org/) for enabling syntax highlight in LaTeX using `minted`; that is the most flexible highlighting method for adding code snippets to your documents.

- Also consider installing extension [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop) for automatic compilation in editor with built-in PDF visualization.

To append to `TEXMF` variable one can use the MiKTeX Console graphical interface and under `Settings > Directories` navigate and select the local path. 

<!-- Alternativelly on can add to the `[Paths]` section of  `bin/apps/miktex-portable/texmfs/install/miktex/config/miktexstartup.ini` a line as `CommonRoots=C:/Path/To/Kompanion/bin/data/texmf` pointing to a directory implementing the project [TeX Directory Structure](https://miktex.org/kb/tds). You might need to add the section to the file, as `[Paths]` is not present in the as-installed condition. -->

If you prefer a dedicated LaTeX editor, you may wish to install [texstudio](https://www.texstudio.org/#download); some configuration of paths with the application may be required as it is not directly integrated to this environment.
