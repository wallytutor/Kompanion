# Software specific instructions

## DualSPHysics

For [DualSPHysics](https://dual.sphysics.org/downloads/) one might also want to install [this FreeCAD addon](https://github.com/DualSPHysics/DesignSPHysics) and [this Blender addon](https://github.com/EPhysLab-UVigo/VisualSPHysics).

## MFiX

This package is [installed](https://mfix.netl.doe.gov/products/mfix/download/) in a separate environment and not added to the toolbox path; that is because other Python environments could interact with each other and lead to unpredictable behavior. The following instructions are provided:

- Install [miniforge3](https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Windows-x86_64.exe) under the `apps/` directory.

- Launch miniforge console by running:

```shell
%windir%\system32\cmd.exe "/K" ^
    %~dp0\miniforge3\Scripts\activate.bat ^
    %~dp0\miniforge3
```

- Go to the [downloads](https://mfix.netl.doe.gov/mfix/download-mfix) page, login and copy the personal installation command that looks like the following:

```shell
conda create -n mfix-<version> ^
    mfix==<version>            ^
    mfix-doc==<version>        ^
    mfix-gui==<version>        ^
    mfix-solver==<version>     ^
    mfix-src==<version>        ^
    -c conda-forge -c     ^
    https://mfix.netl.doe.gov/s3/<personal-token>//conda/dist
```

- To run the software activate the created environment and call its executable:

```shell
conda activate mfix-<version>
mfix
```
