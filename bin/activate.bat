@REM @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@REM CONFIGURE ENVIRONMENT
@REM @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

@REM Main variable for configuration of the environment:
set KOMPANION_ROOT=%~dp0

@REM Path to where applications are installed:
set KOMPANION_APPS=%KOMPANION_ROOT%apps

@REM Path to where data is stored:
set KOMPANION_DATA=%KOMPANION_ROOT%data

@REM Path to where data is stored:
set KOMPANION_SCRIPTS=%KOMPANION_ROOT%scripts

@REM Path to where packages are stored:
set KOMPANION_PKGS=%KOMPANION_ROOT%pkgs

@REM If greater than 0, will update the environment:
set KOMPANION_UPDATE=0

@REM Some software may require a specific locale to be set:
set LANG="en_US.UTF-8"

@REM These may also contain launcher scripts/applications:
set PATH=%KOMPANION_ROOT%;%PATH%
set PATH=%KOMPANION_APPS%;%PATH%

@REM @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@REM BASE PACKAGES
@REM @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

call %KOMPANION_SCRIPTS%\base-vscode.bat
call %KOMPANION_SCRIPTS%\base-git.bat

@REM @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@REM ADDITIONAL PACKAGES
@REM @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

call %KOMPANION_SCRIPTS%\extra-latex.bat
call %KOMPANION_SCRIPTS%\extra-paraview.bat
call %KOMPANION_SCRIPTS%\extra-gnuplot.bat
call %KOMPANION_SCRIPTS%\extra-freecad.bat
call %KOMPANION_SCRIPTS%\extra-blender.bat
call %KOMPANION_SCRIPTS%\extra-salome.bat
call %KOMPANION_SCRIPTS%\extra-gmsh.bat
call %KOMPANION_SCRIPTS%\extra-meshlab.bat
call %KOMPANION_SCRIPTS%\extra-elmer.bat
call %KOMPANION_SCRIPTS%\extra-su2.bat

@REM @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@REM LANGUAGES (COME LAST TO OVERRIDE PREVIOUSLY FOUND INTERPRETERS)
@REM @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

call %KOMPANION_SCRIPTS%\base-julia.bat
call %KOMPANION_SCRIPTS%\base-python.bat
call %KOMPANION_SCRIPTS%\base-octave.bat
call %KOMPANION_SCRIPTS%\base-ruby.bat

@REM Jupyter to be used with IJulia.
set JUPYTER=%PYTHON_HOME%\Scripts\jupyter.exe
set JUPYTER_DATA_DIR=%KOMPANION_DATA%\jupyter

@REM @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@REM TWEAKS
@REM @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

if exist "%KOMPANION_SCRIPTS%\tweaks.bat" ( 
    echo Overriding some setups.
    call %KOMPANION_SCRIPTS%\tweaks.bat
) else ( 
    echo No tweaks file found... keeping defaults.
)

@REM @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@REM EOF
@REM @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@