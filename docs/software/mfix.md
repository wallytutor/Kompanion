# MFiX

This package is [installed](https://mfix.netl.doe.gov/products/mfix/download/) in a separate environment and not added to the toolbox path; that is because other Python environments could interact with each other and lead to unpredictable behavior. The following instructions are provided:

- Install [miniforge3](https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Windows-x86_64.exe) under the `apps/` directory.

- Launch miniforge console by running:

```shell
%windir%\system32\cmd.exe "/K" ^
    %~dp0\miniforge3\Scripts\activate.bat ^
    %~dp0\miniforge3
```

- Run the followinh from within the console:

```shell
conda create -n mfix-24.3 ^
    mfix==24.3            ^
    mfix-doc==24.3        ^
    mfix-gui==24.3        ^
    mfix-solver==24.3     ^
    mfix-src==24.3        ^
    -c conda-forge -c     ^
    https://mfix.netl.doe.gov/s3/5d6af090/de9eeb6bfb5267b7bca77a75b3566311//conda/dist
```

- To run the software activate the created environment and call its executable:

```shell
conda activate mfix-24.3
mfix
```
