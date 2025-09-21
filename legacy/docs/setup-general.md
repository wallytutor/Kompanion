# General setup

First of all, [download](https://github.com/wallytutor/Kompanion/archive/refs/heads/main.zip) or clone this repository somewhere in the target computer. You can consider using [GitHub Desktop](https://github.com/apps/desktop) at this stage, assuming you do not have Git yet or you lack the skills to use it. Unless stated otherwise, everything that follows here is performed under `bin/` directory, so we refer to its sub-directoires directly, *i.e.* `downloads/` means `bin/downloads/`.

**IMPORTANT:** After installing `VS Code`, do **NOT** enable its [portable mode](https://code.visualstudio.com/docs/editor/portable) because the VBS file for launching it will point to a specific user-data folder.

**NOTE:** After finishing the configuration in the following sub-sections, you can test the setup by launching VS Code with prototype launcher `code.bat`. If everything is properly set, the above applications will be available in the command prompt of the editor. This script is provided only for testing (because it will show all the startup logs). The production version is `kode.vbs` in the repository root directory.

## Workflow explained

This section illustrates the generalities of how do integrate portable software in the toolbox. Before proceding with any installation, make sure to read all the elements provided below; simply trying to follow instructions in a step-by-step fashion will certainly lead to failure and frustration.

**IMPORTANT:** You need to be aware that there are two common practices of compressing a portable software: (1) some editors place everything in a directory and compress the directory, while others (2) pack everything under the root of the compressed file. Windows built-in system allows your to navigate compressed files as part of the filesystem, so inspect which of the above methods was used. If the later is detected, take care to select the right option to ensure the contents are extracted to a new directory. Several packages are stored directly at *zip* root and that may be messy to clean if extracted without the above precautions.

**IMPORTANT:** Since setting up the environment requires editing [batch scripts](https://www.tutorialspoint.com/batch_script/index.htm), be aware that to open them you cannot *click* the file, but *right-click* and *edit*, as Windows see these as executables. In these files, lines starting by `@REM` are seem as comments and generally explain something about what follow them.

For each of the applications you will install, make sure to perform the following generic steps:

1. Download the portable version of the application, generally a `.zip` compressed file, and save it to `downloads/`. Sometimes the normal installer of an application already supports portable mode.

2. Extract the compressed file to a dedicated folder under `apps/` directory.

3. Configure the application in a dedicated script under `scripts/` directory.

4. For non-base applications, you might need to add the script to `activate.bat`, which is responsible by making sure all the executables may be found in your environment.

## Initial setup

These are the required steps to get your system working for the first time:

1. Go to VS Code [download page](https://code.visualstudio.com/download) and get the `.zip` version for `x64` system (`Arm64` is not supported here). Extract it to `apps/` and copy the name of VS Code directory to edit `scripts/base-vscode.bat` variable `VSCODE_DIR`. 

2. Go to Git [download page](https://git-scm.com/download/win) and select *64-bit Git for Windows Portable*, download it and move the file to `downloads`. Notice that this is not a compressed file *per se*, but it is desguised as an executable. Double-click it and accept the default `PortableGit` installation directory. After extraction finishes, move it to `apps/`; there is nothing left to configure, but you can inspect `scripts/base-git.bat`.

3. (optional) Go to Neovim [download page](https://github.com/neovim/neovim/releases) and select the zip version for Windows. Follow the standard extration-installation procedure explained above. **Note:** the automation of configuration path for `.vim/` directory is yet to be done.

## MSYS2

MSYS2 environment is useful for developing native Windows applications and programming in languages as C, C++, Fortran, and Rust. Kompanion VS Code configuration will automatically include this environment to its available terminal lists, what might fail if you do not install it. To get it working do the following:

- Go to MSYS2 [page](https://www.msys2.org/) and save the installer to `downloads`.

- Run the installer and change installation path to point to `apps/msys64` instead of the default `C:/msys64` (requiring admin rights).

- Once finished, launch an [UCRT64](https://www.msys2.org/docs/environments/) environment as proposed in the installation guide. Install at least the following:

```bash
pacman -S \
    mingw-w64-ucrt-x86_64-toolchain \
    mingw-w64-ucrt-x86_64-binutils \
    mingw-w64-ucrt-x86_64-gcc \
    mingw-w64-ucrt-x86_64-gcc-fortran
```

- Full package list is provided [here](https://packages.msys2.org/queue).
