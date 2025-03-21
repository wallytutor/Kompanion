# Kompanion

A portable toolbox setup for working in Scientific Computing under Windows.

**NOTE:** before using this, please be aware that your company/university probably forbids the use of portable tools outside sandboxed systems. It is your responsability to use this toolbox only in systems where you are allowed to. The developper does not hold any resposibility on your failure to respect your local regulations.

Please notice that for teaching purposes there is also a simpler [Julia101](https://github.com/wallytutor/julia101) environment setup. This repository is mostly focused on the conception of a production working environment.

## How does it work?

*Kompanion* is intended to be used as a portable environment with *almost* all batteries included. Applications are placed under `bin/` directory and all configuration of paths and other required environment variables are provided by *batch scripts*. Everything revolves around [VS Code](https://code.visualstudio.com/download); you launch the editor through a dedicated script and everything else is available in its terminal. That said, the whole of the ecosystem is command line based, but this is scientific computing, if you don't know command line you are in the wrong job. It is intended to leave minimal track on host system (probably a few files and directories on your user home directory or under *AppData*), but this is not enforced in its development, so take care if you are not allowed to execute some software in a given computer.

**NOTE:** by *almost* all batteries included it is meant that all target applications can be deployed by the user with one exception, [Microsoft MPI ](https://learn.microsoft.com/en-us/message-passing-interface/microsoft-mpi). That requires administration rights and unless you have it you will need to ask your local IT for installing it. If your applications do not require parallel computing, then you have everything you need here.

## Known limitations

- As already stated, MPI support still requires admin rights.

- You cannot pin the editor to the taskbar (because of how sourcing environment works), but you can create a shortcut to `kode.vbs` in your desktop.

## Workspace setup

Please, visit the dedicated [page](docs/setup-general.md) for instructions.

## Tested packages

The above was tested with the following versions:

| Group    | Software       | Version               |
|:--------:|----------------|:----------------------|
| Base     | VS Code        | 1.96.4                |
| Base     | Neovim         | 0.10.4                |
| Base     | Notepad++      | 8.7.8                 |
| Base     | Git            | 2.47.1.2              |
| Base     | MSYS2          | 20250221              |
| Language | Julia          | 1.11.3                |
| Language | WinPython      | 3.13.1.0slim          |
| Language | Octave         | 9.3.0                 |
| Language | Ruby           | 3.3.7-1               |
| Language | Rust           | 1.85                  |
| Language | Quarto         | 1.6.42                |
| Extra    | MiKTeX         | 24.1                  |
| Extra    | JabRef         | 5.15                  |
| Extra    | pandoc         | 3.6.2                 |
| Extra    | inkscape       | 1.4                   |
| Extra    | Fiji           | 1.54p (Java 1.8.0_322)|
| Extra    | FreeCAD        | 1.0.0                 |
| Extra    | Blender        | 4.3.2                 |
| Extra    | SALOME         | 9.13.0                |
| Extra    | gmsh           | 4.13.1                |
| Extra    | MeshLab        | 2023.12d              |
| Extra    | ParaView       | 5.13.2-MPI            |
| Extra    | gnuplot        | 6.0.0                 |
| Extra    | Elmer          | 9.0                   |
| Extra    | SU2            | 8.1.0-mpi             |
| Extra    | RadCal         | 2.0                   |
| Extra    | iperf          | 3.18                  |
| Extra    | MFiX           | 24.4.1                |
| Extra    | Cantera        | Upcoming...           |
| Extra    | CasADi         | Upcoming...           |
| Extra    | DualSPHysics   | Upcoming...           |
| Extra    | DWSIM          | Upcoming...           |
| Extra    | FreeFEM++      | Upcoming...           |
| Extra    | LAMMPS         | Upcoming...           |
| Extra    | OpenModelica   | Upcoming...           |
