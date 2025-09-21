# kompanion.ps
# TODO create Conditional-Extract with a parameter for the kind
# TODO make variables within functions more idiomatic (pascalCase)

# ---------------------------------------------------------------------------
# GLOBAL
# ---------------------------------------------------------------------------

param (
    [switch]$RebuildOnStart,
    [switch]$EnableLang,
    [switch]$EnablePython,
    [switch]$EnableJulia,
    [switch]$EnableRacket
)

$env:KOMPANION      = "$PSScriptRoot"
$env:KOMPANION_BIN  = "$env:KOMPANION/bin"
$env:KOMPANION_DATA = "$env:KOMPANION/data"
$env:KOMPANION_PKG  = "$env:KOMPANION/pkg"

# TODO parse from JSON:
$KOMPANION_NAME_PYTHON = "WPy64-3170b4"
$KOMPANION_NAME_JULIA  = "julia-1.11.7"
$KOMPANION_NAME_RACKET = "racket"

if ($EnableLang) {
    Write-Host "Enabling all languages"
    $EnablePython = $true
    $EnableJulia  = $true
    $EnableRacket = $true
}

# ---------------------------------------------------------------------------
# HELPERS
# ---------------------------------------------------------------------------

function Kompanion-Path() {
    param ( [string]$ChildPath )
    Join-Path -Path $env:KOMPANION -ChildPath $ChildPath
}

function Test-InPath() {
    param( [string]$Directory )

    $normalized = $Directory.TrimEnd('\')
    $filtered = ($env:Path -split ';' | ForEach-Object { $_.TrimEnd('\') })

    return $filtered -contains $normalized
}

function Prepend-Path() {
    param ( [string]$Directory )

    if (Test-Path -Path $Directory) {
        if (Test-InPath $Directory) {
            Write-Host "Skipping already sourced: $Directory"
        } else {
            Write-Host "Prepending to path: $Directory"
            $env:Path = "$Directory;" + $env:Path
        }
    } else {
        Write-Host "Not prepeding missing path to environment: $Directory"
    }
}

function Module-Load() {
    Write-Host "Sorry, WIP..."
}

function Module-List() {
    Write-Host "Sorry, WIP..."
}

function Piperish() {
    $pythonPath = "$env:PYTHON_HOME/python.exe"

    if (Test-Path -Path $pythonPath) {
        $argList = @("-m", "pip", "--trusted-host", "pypi.org",
                     "--trusted-host", "files.pythonhosted.org") + $args

        Start-Process -FilePath $pythonPath -ArgumentList $argList `
            -NoNewWindow -Wait
    } else {
        Write-Host "Python executable not found!"
    }
}

# ---------------------------------------------------------------------------
# BUILD CORE
# ---------------------------------------------------------------------------

function Conditional-Download() {
    param ( [string]$URL, [string]$Output )

    if (Test-Path -Path $Output) {
        Write-Host "Skipping download of $URL..."
    } else {
        Write-Host "Downloading $URL as $Output"
        Start-BitsTransfer -Source $URL -Destination $Output
    }
}

function Conditional-Unzip() {
    param ( [string]$Source, [string]$Destination )

    if (Test-Path -Path $Destination) {
        Write-Host "Skipping extraction of $Source..."
    } else {
        Write-Host "Expanding $Source intp $Destination"
        Expand-Archive -Path $Source -DestinationPath $Destination
    }
}

function Conditional-Untar() {
    param ( [string]$Source, [string]$Destination )

    if (Test-Path -Path "$Destination") {
        Write-Host "Skipping extraction of $Source..."
    } else {
        Write-Host "Expanding $Source intp $Destination"
        New-Item -Path "$Destination" -ItemType Directory
        tar -xzf $Source -C $Destination
    }
}

function Handle-Zip-Install() {
    param ( [string]$URL, [string]$Output, [string]$Destination)

    Conditional-Download -URL $URL -Output $Output
    Conditional-Unzip -Source $Output -Destination $Destination
}

function Handle-Tar-Install() {
    param ( [string]$URL, [string]$Output, [string]$Destination )

    Conditional-Download -URL $URL -Output $Output
    Conditional-Untar -Source $Output -Destination $Destination
}

# ---------------------------------------------------------------------------
# BUILD DOWNLOADS
# ---------------------------------------------------------------------------

function Handle-VSCode() {
    $URL = "https://update.code.visualstudio.com"
    $URL = "$URL/latest/win32-x64-archive/stable"
    Handle-Zip-Install -URL $URL `
        -Output "$PSScriptRoot/temp/vscode.zip" `
        -Destination "$PSScriptRoot/bin/vscode"
}

function Handle-Msys2() {
    $URL = "https://github.com/msys2/msys2-installer/releases/download"
    $URL = "$URL/2025-08-30/msys2-x86_64-20250830.exe"

    $Source = "$PSScriptRoot/temp/msys2.exe"
    $Destination = "$PSScriptRoot/bin/msys2"
    $ArgList = "in --confirm-command --accept-messages --root $Destination"

    Conditional-Download -URL $URL -Output $Source

    if (Test-Path -Path $Destination) {
        Write-Host "Skipping extraction of $Source..."
    } else {
        Write-Host "Expanding $Source intp $Destination"
        Start-Process -FilePath $Source -ArgumentList $ArgList -Wait
    }

    # Start-Process "$PSScriptRoot/bin/msys2/usr/bin/bash.exe" `
    #     -ArgumentList "-lc"
    # Start-Process -FilePath "bin/msys2/usr/bin/bash.exe" `
    # -ArgumentList @("-lc", "echo hello; uname -a; ls -l") `
    # -NoNewWindow -Wait
    # pacman-key --init && pacman-key --populate msys2
    # pacman -Syuu && pacman -S bash coreutils make gcc p7zip
    # pacman -Sy --noconfirm; pacman -S --noconfirm p7zip
}

function Handle-7Z() {
    $URL = "https://github.com/ip7z/7zip/releases/download"
    $URL = "$URL/25.01/7zr.exe"

    $Source = "$PSScriptRoot/temp/7zr.exe"
    $Destination = "$PSScriptRoot/bin/7zr.exe"

    Conditional-Download -URL $URL -Output $Source

    if (Test-Path -Path $Destination) {
        Write-Host "Skipping extraction of $Source..."
    } else {
        Write-Host "Expanding $Source intp $Destination"
        Copy-Item -Path $Source -Destination $Destination
    }
}

function Handle-Git() {
    $URL = "https://github.com/git-for-windows/git/releases/download"
    $URL = "$URL/v2.51.0.windows.1/PortableGit-2.51.0-64-bit.7z.exe"

    $Source = "$PSScriptRoot/temp/git-installer.exe"
    $Destination = "$PSScriptRoot/bin/git"
    $ArgList = "-y", "-o$Destination"

    Conditional-Download -URL $URL -Output $Source

    if (Test-Path -Path $Destination) {
        Write-Host "Skipping extraction of $Source..."
    } else {
        Write-Host "Expanding $Source intp $Destination"
        Start-Process -FilePath $Source -ArgumentList $ArgList -Wait
    }
}

function Handle-Python() {
    param( [pscustomobject]$Config )

    $output       = Kompanion-Path $Config.saveAs
    $path         = Kompanion-Path $Config.path
    $requirements = Kompanion-Path $Config.requirements

    Handle-Zip-Install -URL $Config.URL -Output $output -Destination $path

    Setup-Python
    Piperish "install" "-r" $requirements
}

function Handle-Julia() {
    param( [pscustomobject]$Config )

    $output       = Kompanion-Path $Config.saveAs
    $path         = Kompanion-Path $Config.path
    $requirements = Kompanion-Path $Config.requirements

    Handle-Zip-Install -URL $Config.URL -Output $output -Destination $path

    Setup-Julia

    # XXX: this may take a long time...
    $juliaPath = "$env:JULIA_HOME/julia.exe"
    $argList = @("-e", "exit()")
    Start-Process -FilePath $juliaPath -ArgumentList $argList `
            -NoNewWindow -Wait
}

function Handle-Racket() {
    param( [pscustomobject]$Config )
    
    $output = Kompanion-Path $Config.saveAs
    $path   = Kompanion-Path $Config.path

    Handle-Tar-Install -URL $Config.URL -Output $output -Destination $path
}

# ---------------------------------------------------------------------------
# BUILD
# ---------------------------------------------------------------------------

function Kompanion-Build() {
    Write-Host "Starting Kompanion setup!"

    $jsonText = Get-Content -Path "$env:KOMPANION/kompanion.json" -Raw
    $kompanionConfig = $jsonText | ConvertFrom-Json

    Handle-VSCode
    Handle-7Z
    Handle-Git

    if ($EnablePython) { Handle-Python -Config $kompanionConfig.install.python }
    if ($EnableJulia)  { Handle-Julia  -Config $kompanionConfig.install.julia }
    if ($EnableRacket) { Handle-Racket -Config $kompanionConfig.install.racket }

    # Download/install only:
    # blender-4.3.2-windows-x64
    # DWSIM_v901_Windows_Portable
    # FreeCAD_1.0.0-conda-Windows-x86_64-py311
    # inkscape

    # LaTeX pack:
    # miktex-portable
    # JabRef

    # Handle-Msys2 # XXX: not ready!
    # ElmerFEM-gui-mpi-Windows-AMD64
    # gmsh-4.13.1-Windows64-sdk
    # gnuplot
    # Graphviz-12.2.1-win64
    # MeshLab2023.12d-windows
    # pandoc-3.6.3
    # ParaView
    # portacle
    # SALOME-9.13.0
    # scilab-2025.1.0
    # SU2-v8.1.0-win64-mpi
    # Zettlr-3.4.3-x64
    # radcal_win_64.exe
}

# ---------------------------------------------------------------------------
# SETUP
# ---------------------------------------------------------------------------

function Setup-VSCode() {
    $env:VSCODE_HOME = "$env:KOMPANION_BIN/vscode"
    Prepend-Path -Directory "$env:VSCODE_HOME"

    $env:VSCODE_EXTENSIONS = "$env:KOMPANION_DATA/vscode/extensions"
    $env:VSCODE_SETTINGS   = "$env:KOMPANION_DATA/vscode/user-data"
}

function Setup-Git() {
    $env:GIT_HOME = "$env:KOMPANION_BIN/git"
    Prepend-Path -Directory "$env:GIT_HOME/cmd"
}

function Setup-Python() {
    $env:PYTHON_HOME = "$env:KOMPANION_BIN/python/$KOMPANION_NAME_PYTHON/python"
    Prepend-Path -Directory "$env:PYTHON_HOME/Scripts"
    Prepend-Path -Directory "$env:PYTHON_HOME"

    # Jupyter to be used with IJulia (if any) and data path:
    $env:JUPYTER = "$env:PYTHON_HOME/Scripts/jupyter.exe"
    $env:JUPYTER_DATA_DIR = "$env:KOMPANION_DATA/jupyter"
}

function Setup-Julia() {
    $env:JULIA_HOME = "$env:KOMPANION_BIN/julia/$KOMPANION_NAME_JULIA/bin"
    Prepend-Path -Directory "$env:JULIA_HOME"

    $env:JULIA_DEPOT_PATH   = "$env:KOMPANION_DATA/julia"
    $env:JULIA_CONDAPKG_ENV = "$env:KOMPANION_DATA/CondaPkg"
}

function Setup-Racket() {
    $env:RACKET_HOME = "$env:KOMPANION_BIN/racket/$KOMPANION_NAME_RACKET"
    Prepend-Path -Directory "$env:RACKET_HOME"
}

# ---------------------------------------------------------------------------
# MAIN
# ---------------------------------------------------------------------------

function Kompanion-Setup() {
    Prepend-Path -Directory "$env:KOMPANION_BIN"

    Setup-VSCode
    Setup-Git

    if ($EnablePython) { Setup-Python }
    if ($EnableJulia)  { Setup-Julia }
    if ($EnableRacket) { Setup-Racket }

    # TODO pull all submodules!

    Code.exe `
        --extensions-dir $env:VSCODE_EXTENSIONS `
        --user-data-dir  $env:VSCODE_SETTINGS  .
}

# ---------------------------------------------------------------------------
# MAIN
# ---------------------------------------------------------------------------

if ($RebuildOnStart) { Kompanion-Build }

Write-Output @"
Starting Kompanion from $PSScriptRoot!

Environment
-----------
KOMPANION             $env:KOMPANION
env:KOMPANION_BIN     $env:KOMPANION_BIN
env:KOMPANION_DATA    $env:KOMPANION_DATA

Other paths
-----------
VSCODE_HOME           $env:VSCODE_HOME
VSCODE_EXTENSIONS     $env:VSCODE_EXTENSIONS
VSCODE_SETTINGS       $env:VSCODE_SETTINGS
GIT_HOME              $env:GIT_HOME
"@

# ---------------------------------------------------------------------------
# EOF
# ---------------------------------------------------------------------------