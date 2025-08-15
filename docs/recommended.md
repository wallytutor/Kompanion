# Recommended software

## VS Code extensions

### Languages support

- [C/C++](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)
- [Even Better TOML](https://marketplace.visualstudio.com/items?itemName=tamasfe.even-better-toml)
- [Gmsh](https://marketplace.visualstudio.com/items?itemName=Bertrand-Thierry.vscode-gmsh)
- [Julia](https://marketplace.visualstudio.com/items?itemName=julialang.language-julia)
- [Jupyter](https://marketplace.visualstudio.com/items?itemName=ms-toolsai.jupyter)
- [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop)
- [Matlab](https://marketplace.visualstudio.com/items?itemName=MathWorks.language-matlab)
- [Modern Fortran](https://marketplace.visualstudio.com/items?itemName=fortran-lang.linter-gfortran)
- [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python)
- [Quarto](https://marketplace.visualstudio.com/items?itemName=quarto.quarto)
- [Ruby](https://marketplace.visualstudio.com/items?itemName=Shopify.ruby-extensions-pack)

### Data inspection

- [Data Wrangler](https://marketplace.visualstudio.com/items?itemName=ms-toolsai.datawrangler)
- [Excel Viewer](https://marketplace.visualstudio.com/items?itemName=GrapeCity.gc-excelviewer)
- [Rainbow CSV](https://marketplace.visualstudio.com/items?itemName=mechatroner.rainbow-csv)

### General utilities

- [Copilot](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot)
- [Live Server](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer)
- [Rewrap Revived](https://marketplace.visualstudio.com/items?itemName=dnut.rewrap-revived)
- [Remote SSH](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh)

### Themes

- [Ayu Monokai](https://marketplace.visualstudio.com/items?itemName=lakshits11.ayu-monokai)
- [Julia Color Themes](https://marketplace.visualstudio.com/items?itemName=cameronbieganek.julia-color-themes)

## Science and Engineering

- [Cantera](https://github.com/Cantera/cantera/releases/tag/v3.0.0)
- [CasADi](https://web.casadi.org/get/)
- [DualSPHysics](https://dual.sphysics.org/downloads/)
- [DWSIM](https://dwsim.org/index.php/download/)
- [ElmerFEM](https://www.nic.funet.fi/pub/sci/physics/elmer/bin/windows/)
- [FreeFem++](https://github.com/FreeFem/FreeFem-sources/releases)
- [LAMMPS](https://packages.lammps.org/windows.html)
- [OpenModelica](https://openmodelica.org/download/download-windows/)
- [RadCal](https://github.com/firemodels/radcal)
- [SU2](https://su2code.github.io/download.html)

## Geometry and preprocessing

- [Blender](https://www.blender.org/download/)
- [FreeCAD](https://www.freecad.org/downloads.php)
- [gmsh](https://gmsh.info/#Download)
- [MeshLab](https://github.com/cnr-isti-vclab/meshlab)
- [ParaView](https://www.paraview.org/download/)
- [Salome](https://www.salome-platform.org/?page_id=2430)

## Graphics

- [Fiji](https://imagej.net/software/fiji/downloads)
- [gnuplot](https://sourceforge.net/projects/gnuplot/files/gnuplot/6.0.0/)
- [Graphviz](https://graphviz.org/download/)

## Other software

The following are known to be installable in a portable fashion (but some of them might require some ingenious ways of preparing portable versions from official distributions).

- 7-zip
- Dyssol
- FileZilla
- [iperf](https://iperf.fr/)
- Ipopt
- Jamovi
- JASP
- lazarus
- [lite-xl](https://github.com/lite-xl/lite-xl)
- MSYS2
- MUSEN
- [Notepad++](https://notepad-plus-plus.org/downloads/)
- nteract
- OpenCALPHAD
- Orange3
- puTTy
- Rufus
- Scilab
- strawberry-perl
- Tabby
- VMD
- [ZeroBraneStudio](https://studio.zerobrane.com/)
- [Zettlr](https://www.zettlr.com/)
- [Xpra](https://xpra.org/index.html)

## Software specific instructions

### DualSPHysics

For [DualSPHysics](https://dual.sphysics.org/downloads/) one might also want to install [this FreeCAD addon](https://github.com/DualSPHysics/DesignSPHysics) and [this Blender addon](https://github.com/EPhysLab-UVigo/VisualSPHysics).

### MFiX

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
    -c conda-forge -c          ^
    https://mfix.netl.doe.gov/s3/<personal-token>//conda/dist
```

- To run the software activate the created environment and call its executable:

```shell
conda activate mfix-<version>
mfix
```
