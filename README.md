# Kompanion

A portable toolbox setup for working in Scientific Computing under Windows.

**NOTE:** before using this, please be aware that your company/university probably forbids the use of portable tools outside sandboxed systems. It is your responsability to use this toolbox only in systems where you are allowed to. The developper does not hold any resposibility on your failure to respect your local regulations.

## How does it work?

*Kompanion* is intended to be used as a portable environment with *almost* all batteries included. Applications are placed under `bin/` directory and all configuration of paths and other required environment variables are provided by [batch scripts](https://www.tutorialspoint.com/batch_script/index.htm). Everything revolves around [VS Code](https://code.visualstudio.com/download); you launch the editor through a dedicated script and everything else is available in its terminal. That said, the whole of the ecosystem is command line based, but this is scientific computing, if you don't know command line you are in the wrong job. It is intended to leave minimal track on host system (probably a few files and directories on your user home directory or under *AppData*), but this is not enforced in its development, so take care if you are not allowed to execute some software in a given computer.

**NOTE:** by *almost* all batteries included it is meant that all target applications can be deployed by the user with one exception, [Microsoft MPI ](https://learn.microsoft.com/en-us/message-passing-interface/microsoft-mpi). That requires administration rights and unless you have it you will need to ask your local IT for installing it. If your applications do not require parallel computing, then you have everything you need here.

## Kompanion setup

First of all, [download](https://github.com/wallytutor/Kompanion/archive/refs/heads/main.zip) or clone this repository somewhere in the target computer. You can consider using [GitHub Desktop](https://github.com/apps/desktop) at this stage, assuming you do not have Git yet or you lack the skills to use it. Unless stated otherwise, everything that follows here is performed under `bin/` directory, so we refer to its sub-directoires directly, *i.e.* `downloads/` means `bin/downloads/`.

### Workflow explained

This section illustrates the generalities of how do integrate portable software in the toolbox. Before proceding with any installation, make sure to read all the elements provided below; simply trying to follow instructions in a step-by-step fashion will certainly lead to failure and frustration.

**IMPORTANT:** You need to be aware that there are two common practices of compressing a portable software: (1) some editors place everything in a directory and compress the directory, while others (2) pack everything under the root of the compressed file. Windows built-in system allows your to navigate compressed files as part of the filesystem, so inspect which of the above methods was used. If the later is detected, take care to select the right option to ensure the contents are extracted to a new directory. Several packages are stored directly at *zip* root and that may be messy to clean if extracted without the above precautions.

**IMPORTANT:** Since setting up the environment requires editing [batch scripts](https://www.tutorialspoint.com/batch_script/index.htm), be aware that to open them you cannot *click* the file, but *right-click* and *edit*, as Windows see these as executables. In these files, lines starting by `@REM` are seem as comments and generally explain something about what follow them.

For each of the applications you will install, make sure to perform the following generic steps:

1. Download the portable version of the application, generally a `.zip` file, and save it to `downloads`.

2. Extract the compressed file to a dedicated folder under `apps/` directory.

3. Configure the application in a dedicated script under `scripts/` directory.

4. For non-base applications, you might need to add the script to `activate.bat`, which is responsible by making sure all the executables may be found in your environment.

### Base deployment

1. Go to VS Code [download page](https://code.visualstudio.com/download) and get the `.zip` version for `x64` system (`Arm64` is not supported here). Extract it to `apps/` and copy the name of VS Code directory to edit `scripts/base-vscode.bat` variable `DIR_VSCODE`.

2. 
