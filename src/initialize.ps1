# -*- powershell -*-

function Initialize-VSCode() {
    param( [pscustomobject]$obj )
    $env:VSCODE_HOME = Get-KompanionPath $obj.path
    Add-ToPath -Directory "$env:VSCODE_HOME"

    $env:VSCODE_EXTENSIONS = Convert-ToBackSlash "$env:KOMPANION_DATA\vscode\extensions"
    $env:VSCODE_SETTINGS   = Convert-ToBackSlash "$env:KOMPANION_DATA\vscode\user-data"
}

function Initialize-Git() {
    param( [pscustomobject]$obj )
    $env:GIT_HOME = Get-KompanionPath $obj.path
    Add-ToPath -Directory "$env:GIT_HOME\cmd"
}

function Initialize-Lessmsi() {
    param( [pscustomobject]$obj )
    $env:LESSMSI_HOME = Get-KompanionPath $obj.path
    Add-ToPath -Directory "$env:LESSMSI_HOME"
}

function Initialize-Neovim() {
    param( [pscustomobject]$obj )
    $env:NEOVIM_HOME = "$(Get-PackagePath $obj)"
    Add-ToPath -Directory "$env:NEOVIM_HOME\bin"
}

function Initialize-Python() {
    param( [pscustomobject]$obj )
    $env:PYTHON_HOME =  "$(Get-PackagePath $obj)"
    Add-ToPath -Directory "$env:PYTHON_HOME\python\Scripts"
    Add-ToPath -Directory "$env:PYTHON_HOME\python"

    # Jupyter to be used with IJulia (if any) and data path:
    $env:JUPYTER = "$env:PYTHON_HOME\python\Scripts\jupyter.exe"
    $env:JUPYTER_DATA_DIR = "$env:KOMPANION_DATA\jupyter"
}

function Initialize-Julia() {
    param( [pscustomobject]$obj )
    $env:JULIA_HOME = "$(Get-PackagePath $obj)"
    Add-ToPath -Directory "$env:JULIA_HOME\bin"

    $env:JULIA_DEPOT_PATH   = "$env:KOMPANION_DATA\julia"
    $env:JULIA_CONDAPKG_ENV = "$env:KOMPANION_DATA\CondaPkg"
}

function Initialize-Racket() {
    param( [pscustomobject]$obj )
    $env:RACKET_HOME = Get-PackagePath $obj
    Add-ToPath -Directory "$env:RACKET_HOME"
}

function Initialize-MLton() {
    param( [pscustomobject]$obj )
    $env:MLTON_HOME = Get-PackagePath $obj
    Add-ToPath -Directory "$env:MLTON_HOME\bin"
    Add-ToPath -Directory "$env:MLTON_HOME\lib\mlton"
}

function Initialize-SMLNJ() {
    param( [pscustomobject]$obj )
    $env:SMLNJ_HOME = "$(Get-KompanionPath $obj.path)\SourceDir\PFiles\SMLNJ"
    Add-ToPath -Directory "$env:SMLNJ_HOME\bin"
}

function Initialize-Pandoc() {
    param( [pscustomobject]$obj )
    $env:PANDOC_HOME = Get-PackagePath $obj
    Add-ToPath -Directory "$env:PANDOC_HOME"
}

function Initialize-JabRef() {
    param( [pscustomobject]$obj )
    $env:JABREF_HOME = Get-PackagePath $obj
    Add-ToPath -Directory "$env:JABREF_HOME"
}

function Initialize-Inkscape() {
    param( [pscustomobject]$obj )
    $env:INKSCAPE_HOME = "$(Get-PackagePath $obj)"
    Add-ToPath -Directory "$env:INKSCAPE_HOME\bin"
}

function Initialize-MikTeX() {
    param( [pscustomobject]$obj )
    $env:MIKTEX_HOME = Get-PackagePath $obj
    Add-ToPath -Directory "$env:MIKTEX_HOME"

    $path = "$env:MIKTEX_HOME\miktex-portable.cmd"
    Start-Process -FilePath $path -NoNewWindow

    Add-ToPath -Directory "$env:MIKTEX_HOME\texmfs\install\miktex\bin\x64\internal"
    Add-ToPath -Directory "$env:MIKTEX_HOME\texmfs\install\miktex\bin\x64"
}

function Initialize-Elmer() {
    param( [pscustomobject]$obj )
    $env:ELMER_HOME = "$(Get-PackagePath $obj)"
    Add-ToPath -Directory "$env:ELMER_HOME\bin"
}

function Initialize-Gmsh() {
    param( [pscustomobject]$obj )
    $env:GMSH_HOME = "$(Get-PackagePath $obj)"
    Add-ToPath -Directory "$env:GMSH_HOME\bin"
    Add-ToPath -Directory "$env:GMSH_HOME\lib"
    # TODO add to PYTHONPATH;JULIA_LOAD_PATH
}

function Initialize-Kompanion() {
    $config = Get-KompanionConfig
    Add-ToPath -Directory "$env:KOMPANION_BIN"

    Initialize-VSCode  $config.install.vscode
    Initialize-Git     $config.install.git
    Initialize-Lessmsi $config.install.lessmsi
    Initialize-Neovim  $config.install.neovim

    if ($EnableLaTeX) {
        Initialize-Pandoc   $config.install.pandoc
        Initialize-JabRef   $config.install.jabref
        Initialize-Inkscape $config.install.inkscape
        Initialize-MikTeX   $config.install.miktex
    }

    if ($EnableElmer) { Initialize-Elmer $config.install.elmer }
    if ($EnableGmsh)  { Initialize-Gmsh $config.install.gmsh }

    # XXX: languages come last because some packages might override
    # them (especially Python that is used everywhere).
    if ($EnablePython) { Initialize-Python $config.install.python }
    if ($EnableJulia)  { Initialize-Julia  $config.install.julia }
    if ($EnableRacket) { Initialize-Racket $config.install.racket }
    if ($EnableMLton)  { Initialize-MLton  $config.install.mlton }
    if ($EnableSMLNJ)  { Initialize-SMLNJ  $config.install.smlnj }

    # TODO pull all submodules!
}
