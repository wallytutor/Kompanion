@REM FIXME this does not work when running from `activate.bat` itself!

setlocal
call %~dp0..\activate.bat

@REM List of extensions to install
set extensions=
set extensions=%extensions% "GitHub.copilot"
set extensions=%extensions% "tamasfe.even-better-toml"
set extensions=%extensions% "GrapeCity.gc-excelviewer"
set extensions=%extensions% "Bertrand-Thierry.vscode-gmsh"
set extensions=%extensions% "julialang.language-julia"
set extensions=%extensions% "cameronbieganek.julia-color-themes"
set extensions=%extensions% "James-Yu.latex-workshop"
set extensions=%extensions% "MathWorks.language-matlab"
set extensions=%extensions% "ms-python.python"
set extensions=%extensions% "mechatroner.rainbow-csv"
set extensions=%extensions% "dnut.rewrap-revived"
set extensions=%extensions% "Shopify.ruby-extensions-pack"

@REM Still need to do the following manually (see troubleshooting.md):
@REM set extensions=%extensions% "%KOMPANION_PKGS%\elmer-sif-vscode"

@REM Maybe in the future...
@REM ms-vscode.cpptools
@REM esbenp.prettier-vscode

@REM Loop through the list and install each extension
for %%i in (%extensions%) do (
    %VSCODE_HOME%\bin\Code.cmd ^
        --extensions-dir=%VSCODE_EXTENSIONS% ^
        --user-data-dir=%VSCODE_SETTINGS% ^
        --install-extension %%i >> %~dp0post-vscode.done
)

endlocal