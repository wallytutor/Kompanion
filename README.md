# Kompanion

A portable toolbox setup for working in Scientific Computing under Windows.

**NOTE:** before using this, please be aware that your company/university probably forbids the use of portable tools outside sandboxed systems. It is your responsability to use this toolbox only in systems where you are allowed to. The developper does not hold any resposibility on your failure to respect your local regulations.

Please notice that for teaching purposes there is also a simpler [Julia101](https://github.com/wallytutor/julia101) environment setup. This repository is mostly target at production work.

## How does it work?

*Kompanion* is intended to be used as a portable environment with *almost* all batteries included. Applications are placed under `bin/` directory and all configuration of paths and other required environment variables are provided by *batch scripts*. Everything revolves around [VS Code](https://code.visualstudio.com/download); you launch the editor through a dedicated script and everything else is available in its terminal. That said, the whole of the ecosystem is command line based, but this is scientific computing, if you don't know command line you are in the wrong job. It is intended to leave minimal track on host system (probably a few files and directories on your user home directory or under *AppData*), but this is not enforced in its development, so take care if you are not allowed to execute some software in a given computer.

**NOTE:** by *almost* all batteries included it is meant that all target applications can be deployed by the user with one exception, [Microsoft MPI ](https://learn.microsoft.com/en-us/message-passing-interface/microsoft-mpi). That requires administration rights and unless you have it you will need to ask your local IT for installing it. If your applications do not require parallel computing, then you have everything you need here.

## Known limitations

- As already stated, MPI support still requires admin rights.

- You cannot pin the editor to the taskbar (because of how sourcing environment works), but you can create a shortcut to `kode.vbs` in your desktop.

## Workflow explained

This section illustrates the generalities of how do integrate portable software in the toolbox. Before proceding with any installation, make sure to read all the elements provided below; simply trying to follow instructions in a step-by-step fashion will certainly lead to failure and frustration.

**IMPORTANT:** You need to be aware that there are two common practices of compressing a portable software: (1) some editors place everything in a directory and compress the directory, while others (2) pack everything under the root of the compressed file. Windows built-in system allows your to navigate compressed files as part of the filesystem, so inspect which of the above methods was used. If the later is detected, take care to select the right option to ensure the contents are extracted to a new directory. Several packages are stored directly at *zip* root and that may be messy to clean if extracted without the above precautions.

**IMPORTANT:** Since setting up the environment requires editing [batch scripts](https://www.tutorialspoint.com/batch_script/index.htm), be aware that to open them you cannot *click* the file, but *right-click* and *edit*, as Windows see these as executables. In these files, lines starting by `@REM` are seem as comments and generally explain something about what follow them.

For each of the applications you will install, make sure to perform the following generic steps:

1. Download the portable version of the application, generally a `.zip` file, and save it to `downloads`.

2. Extract the compressed file to a dedicated folder under `apps/` directory.

3. Configure the application in a dedicated script under `scripts/` directory.

4. For non-base applications, you might need to add the script to `activate.bat`, which is responsible by making sure all the executables may be found in your environment.

## Kompanion setup

First of all, [download](https://github.com/wallytutor/Kompanion/archive/refs/heads/main.zip) or clone this repository somewhere in the target computer. You can consider using [GitHub Desktop](https://github.com/apps/desktop) at this stage, assuming you do not have Git yet or you lack the skills to use it. Unless stated otherwise, everything that follows here is performed under `bin/` directory, so we refer to its sub-directoires directly, *i.e.* `downloads/` means `bin/downloads/`.

**IMPORTANT:** After installing `VS Code`, do **NOT** enable its [portable mode](https://code.visualstudio.com/docs/editor/portable) because the VBS file for launching it will point to a specific user-data folder.

These are the required steps to get your system working for the first time:

1. Go to VS Code [download page](https://code.visualstudio.com/download) and get the `.zip` version for `x64` system (`Arm64` is not supported here). Extract it to `apps/` and copy the name of VS Code directory to edit `scripts/base-vscode.bat` variable `DIR_VSCODE`. 

2. Go to Git [download page](https://git-scm.com/download/win) and select *64-bit Git for Windows Portable*, download it and move the file to `downloads`. Notice that this is not a compressed file *per se*, but it is desguised as an executable. Double-click it and accept the default `PortableGit` installation directory. After extraction finishes, move it to `apps/`; there is nothing left to configure, but you can inspect `scripts/base-git.bat`.

3. Go to Julia [download page](https://julialang.org/downloads/) and select the latest stable Windows 64-bit portable version. Move the file to `downloads` and extract it, then move the resulting folder to `apps`.

4. Go to WinPython [download page](https://github.com/winpython/winpython/releases) and find the latest version taged with a *Latest* green flag (avoir *Pre-release* versions on top). Expand the *Assets* and download the `.exe` version (also a disguised compressed file). Follow steps similar to Git above, but notice that WinPython will extract directly to `downloads`. After moving the directory to `apps`, set the directory variable in `scripts/base-python.bat`.

5. Go to Octave [download page](https://octave.org/download) and identify the `.zip` package for `w64`.

You can test the setup by launching VS Code with prototype launcher `code.bat`. If everything is properly set, the above applications will be available in the command prompt of the editor.

## Additional packages

- [LaTeX support](docs/latex.md)
- [Recommended packages](docs/recommended.md)

Specific software instructions:

- [DualSPHysics](docs/dualsphysics.md)
- [MFiX](docs/mfix.md)

## Recommended extensions

- [Copilot](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot)
- [Gmsh](https://marketplace.visualstudio.com/items?itemName=Bertrand-Thierry.vscode-gmsh)
- [Julia](https://marketplace.visualstudio.com/items?itemName=julialang.language-julia)
- [Julia Color Themes](https://marketplace.visualstudio.com/items?itemName=cameronbieganek.julia-color-themes)
- [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop)
- [Matlab](https://marketplace.visualstudio.com/items?itemName=MathWorks.language-matlab)
- [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python)
- [Rainbow CSV](https://marketplace.visualstudio.com/items?itemName=mechatroner.rainbow-csv)
- [Rewrap Revived](https://marketplace.visualstudio.com/items?itemName=dnut.rewrap-revived)

## Validated versions

The above was tested with the following versions:

| Group  | Software       | Version      |
|:------:|----------------|:-------------|
| Base   | VS Code        | 1.96.4       |
| Base   | Git            | 2.47.1.2     |
| Base   | Julia          | 1.11.3       |
| Base   | WinPython      | 3.13.1.0slim |
| Extra  | MiKTeX         | 24.1         |
| Extra  | JabRef         | 5.15         |
| Extra  | pandoc         | 3.6.2        |
| Extra  | inkscape       | 1.4          |
| Extra  | FreeCAD        | 1.0.0        |
| Extra  | Blender        | 4.3.2        |
| Extra  | gmsh           | 4.13.1       |
| Extra  | MeshLab        | 2023.12d     |
| Extra  | ParaView       | 5.13.2-MPI   |
| Extra  | gnuplot        | 6.0.0        |
| Extra  | Elmer          | 9.0          |
| Extra  | RadCal         | 2.0          |
