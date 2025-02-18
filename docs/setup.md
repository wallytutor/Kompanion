# Setup

First of all, [download](https://github.com/wallytutor/Kompanion/archive/refs/heads/main.zip) or clone this repository somewhere in the target computer. You can consider using [GitHub Desktop](https://github.com/apps/desktop) at this stage, assuming you do not have Git yet or you lack the skills to use it. Unless stated otherwise, everything that follows here is performed under `bin/` directory, so we refer to its sub-directoires directly, *i.e.* `downloads/` means `bin/downloads/`.

**IMPORTANT:** After installing `VS Code`, do **NOT** enable its [portable mode](https://code.visualstudio.com/docs/editor/portable) because the VBS file for launching it will point to a specific user-data folder.

**NOTE:** After finishing the configuration in the following sub-sections, you can test the setup by launching VS Code with prototype launcher `code.bat`. If everything is properly set, the above applications will be available in the command prompt of the editor. This script is provided only for testing (because it will show all the startup logs). The production version is `kode.vbs` in the repository root directory.

## Workflow explained

This section illustrates the generalities of how do integrate portable software in the toolbox. Before proceding with any installation, make sure to read all the elements provided below; simply trying to follow instructions in a step-by-step fashion will certainly lead to failure and frustration.

**IMPORTANT:** You need to be aware that there are two common practices of compressing a portable software: (1) some editors place everything in a directory and compress the directory, while others (2) pack everything under the root of the compressed file. Windows built-in system allows your to navigate compressed files as part of the filesystem, so inspect which of the above methods was used. If the later is detected, take care to select the right option to ensure the contents are extracted to a new directory. Several packages are stored directly at *zip* root and that may be messy to clean if extracted without the above precautions.

**IMPORTANT:** Since setting up the environment requires editing [batch scripts](https://www.tutorialspoint.com/batch_script/index.htm), be aware that to open them you cannot *click* the file, but *right-click* and *edit*, as Windows see these as executables. In these files, lines starting by `@REM` are seem as comments and generally explain something about what follow them.

For each of the applications you will install, make sure to perform the following generic steps:

1. Download the portable version of the application, generally a `.zip` file, and save it to `downloads`.

2. Extract the compressed file to a dedicated folder under `apps/` directory.

3. Configure the application in a dedicated script under `scripts/` directory.

4. For non-base applications, you might need to add the script to `activate.bat`, which is responsible by making sure all the executables may be found in your environment.

## Initial setup

These are the required steps to get your system working for the first time:

1. Go to VS Code [download page](https://code.visualstudio.com/download) and get the `.zip` version for `x64` system (`Arm64` is not supported here). Extract it to `apps/` and copy the name of VS Code directory to edit `scripts/base-vscode.bat` variable `VSCODE_DIR`. 

2. Go to Git [download page](https://git-scm.com/download/win) and select *64-bit Git for Windows Portable*, download it and move the file to `downloads`. Notice that this is not a compressed file *per se*, but it is desguised as an executable. Double-click it and accept the default `PortableGit` installation directory. After extraction finishes, move it to `apps/`; there is nothing left to configure, but you can inspect `scripts/base-git.bat`.

## Additional packages

Now you can complete your environment setup with the following:

- [Adding languages](setup-languages.md)
- [LaTeX support](setup-latex.md)
- [Recommended packages](recommended.md)

Specific software instructions:

- [DualSPHysics](software/dualsphysics.md)
- [MFiX](software/mfix.md)

## Recommended extensions

- [Copilot](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot)
- [Even Better TOML](https://marketplace.visualstudio.com/items?itemName=tamasfe.even-better-toml)
- [Excel Viewer](https://marketplace.visualstudio.com/items?itemName=GrapeCity.gc-excelviewer)
- [Gmsh](https://marketplace.visualstudio.com/items?itemName=Bertrand-Thierry.vscode-gmsh)
- [Julia](https://marketplace.visualstudio.com/items?itemName=julialang.language-julia)
- [Julia Color Themes](https://marketplace.visualstudio.com/items?itemName=cameronbieganek.julia-color-themes)
- [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop)
- [Matlab](https://marketplace.visualstudio.com/items?itemName=MathWorks.language-matlab)
- [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python)
- [Rainbow CSV](https://marketplace.visualstudio.com/items?itemName=mechatroner.rainbow-csv)
- [Rewrap Revived](https://marketplace.visualstudio.com/items?itemName=dnut.rewrap-revived)
- [Ruby](https://marketplace.visualstudio.com/items?itemName=Shopify.ruby-extensions-pack)
