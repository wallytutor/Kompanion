@REM For LaTeX code highlighting:
@REM Fix Jupyterlab and add more:
@REM Add a few niche packages:
@REM Ensure the scientific basics are there:
@REM Other packages:
if exist "%PYTHON_HOME%\Scripts\pip.exe" ( 
    %PYTHON_HOME%\Scripts\pip         ^
        --trusted-host pypi.org       ^
        --trusted-host files.pythonhosted.org install ^
            Pygments       ^
            ipyparallel    ^
            nbclassic      ^
            voila          ^
            jupytext       ^
            jupyterlab_scenes ^
            jupyterlab-quarto ^
            cantera        ^
            casadi         ^
            FiPy           ^
            graphviz       ^
            py-pde         ^
            numpy          ^
            numba          ^
            mpmath         ^
            scipy          ^
            sympy          ^
            matplotlib     ^
            pandas         ^
            torch          ^
            pywin32        ^
            beautifulsoup4 ^
            pyparsing      ^
            marimo         ^
            pillow         ^
            arrow          ^
            xlrd           ^
            xlsxwriter     ^
            openpyxl       ^
            PyYAML > %~dp0post-python.done
) else ( 
    echo Python has not yet been installed...
)
