# kompanion.ps
# TODO make variables within functions more idiomatic (pascalCase)

# ---------------------------------------------------------------------------
# GLOBAL
# ---------------------------------------------------------------------------

param (
    [switch]$RebuildOnStart,
    [switch]$EnableFull,
    [switch]$EnableLang,
    [switch]$EnableSimu,
    [switch]$EnablePython,
    [switch]$EnableJulia,
    [switch]$EnableRacket,
    [switch]$EnableLaTeX,
    [switch]$EnableElmer,
    [switch]$EnableGmsh
)

$env:KOMPANION      = "$PSScriptRoot"
$env:KOMPANION_BIN  = "$env:KOMPANION/bin"
$env:KOMPANION_DATA = "$env:KOMPANION/data"
$env:KOMPANION_PKG  = "$env:KOMPANION/pkg"

$KOMPANION_LOG = "$env:KOMPANION/kompanion.log"

if ($EnableFull) {
    Write-Host "Enabling all features"
    $EnableLang  = $true
    $EnableSimu  = $true
    $EnableLaTeX = $true
}

if ($EnableLang) {
    Write-Host "Enabling all languages"
    $EnablePython = $true
    $EnableJulia  = $true
    $EnableRacket = $true
}

if ($EnableSimu) {
    Write-Host "Enabling all simulation tools"
    $EnableElmer = $true
    $EnableGmsh  = $true
}

# ---------------------------------------------------------------------------
# HELPERS
# ---------------------------------------------------------------------------

function Kompanion-Path() {
    param ( [string]$ChildPath )
    Join-Path -Path $env:KOMPANION -ChildPath $ChildPath
}

function Package-Path() {
    param( [pscustomobject]$obj )
    Kompanion-Path "$($obj.path)/$($obj.name)"
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
            -NoNewWindow -Wait -RedirectStandardOutput $KOMPANION_LOG
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

function Conditional-Expand() {
    param ( [string]$Source, [string]$Destination, [string]$Method = "ZIP" )

    if (Test-Path -Path $Destination) {
        Write-Host "Skipping extraction of $Source..."
    } else {
        Write-Host "Expanding $Source into $Destination"
        if ($Method -eq "ZIP") {
            Expand-Archive -Path $Source -DestinationPath $Destination
        }
        elseif ($Method -eq "7Z") {
            $argList = @("x", $Source , "-o$Destination")
            Start-Process -FilePath "7zr.exe" -ArgumentList $argList `
                -NoNewWindow -Wait
        }
        elseif ($Method -eq "TAR") {
            New-Item -Path "$Destination" -ItemType Directory
            tar -xzf $Source -C $Destination
        }
        else {
            Write-Host "Unknown expansion method $Method..."
        }
    }
}

function Conditional-Install() {
    param( [pscustomobject]$Config, [string]$Method = "ZIP" )
    $output = Kompanion-Path $Config.saveAs
    $path   = Kompanion-Path $Config.path
    Conditional-Download -URL $Config.URL -Output $output
    Conditional-Expand -Source $output -Destination $path -Method $Method
    return $path
}

# ---------------------------------------------------------------------------
# BUILD DOWNLOADS
# ---------------------------------------------------------------------------

function Handle-VSCode() {
    param( [pscustomobject]$Config )
    Conditional-Install $Config
    Setup-VSCode

    # TODO failing because of certificate
    # foreach ($pkg in $Config.requirements) {
    #     $cmdPath = "$env:VSCODE_HOME\bin\Code.cmd"
    #     $argList = @("--extensions-dir", $env:VSCODE_EXTENSIONS,
    #                  "--user-data-dir",   $env:VSCODE_SETTINGS,
    #                  "--install-extension", $pkg)
    #     Start-Process -FilePath $cmdPath -ArgumentList $argList -NoNewWindow -Wait
    # }
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
        Write-Host "Expanding $Source into $Destination"
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
    param( [pscustomobject]$Config )
    $output  = Kompanion-Path $Config.saveAs
    $path    = Kompanion-Path $Config.path

    Conditional-Download -URL $Config.URL -Output $output

    if (Test-Path -Path $path) {
        Write-Host "Skipping extraction of $output..."
    } else {
        Write-Host "Expanding $output into $path"
        Copy-Item -Path $output -Destination $path
    }
}

function Handle-Git() {
    param( [pscustomobject]$Config )
    $output  = Kompanion-Path $Config.saveAs
    $path    = Kompanion-Path $Config.path

    Conditional-Download -URL $Config.URL -Output $output

    if (Test-Path -Path $path) {
        Write-Host "Skipping extraction of $output..."
    } else {
        Write-Host "Expanding $output into $path"
        $argList = "-y", "-o$path"
        Start-Process -FilePath $output -ArgumentList $argList -Wait
    }
}

function Handle-MikTeXSetup() {
    param( [pscustomobject]$Config )

    $path = Conditional-Install $Config
    $path = "$path/miktexsetup_standalone.exe"

    # TODO bin/miktex is hardcoded here!
    $pkgData = Kompanion-Path $Config.data
    $miktex  = Kompanion-Path "bin/miktex"

    if (Test-Path -Path $pkgData) {
        Write-Host "Skipping download of package data to $pkgData..."
    } else {
        Write-Host "Downloading MikTex data to $pkgData"
        $argList = @("download", "--package-set", "basic",
                    "--remote-package-repository", $Config.repo,
                    "--local-package-repository", $pkgData)
        Start-Process -FilePath $path -ArgumentList $argList -NoNewWindow -Wait
    }

    if (Test-Path -Path $miktex) {
        Write-Host "Skipping install of MikTex to $miktex..."
    } else {
        Write-Host "Installing MikTex data to $miktex"
        $argList = @("install", "--package-set", "basic",
                    "--local-package-repository", $pkgData,
                    "--portable", $miktex)
        Start-Process -FilePath $path -ArgumentList $argList -NoNewWindow -Wait
        Start-Process -FilePath $path -ArgumentList "finish" -NoNewWindow -Wait
    }
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
    param( [pscustomobject]$obj )
    $env:PYTHON_HOME =  "$(Package-Path $obj)/python"
    Prepend-Path -Directory "$env:PYTHON_HOME/Scripts"
    Prepend-Path -Directory "$env:PYTHON_HOME"

    # Jupyter to be used with IJulia (if any) and data path:
    $env:JUPYTER = "$env:PYTHON_HOME/Scripts/jupyter.exe"
    $env:JUPYTER_DATA_DIR = "$env:KOMPANION_DATA/jupyter"
}

function Setup-Julia() {
    param( [pscustomobject]$obj )
    $env:JULIA_HOME = "$(Package-Path $obj)/bin"
    Prepend-Path -Directory "$env:JULIA_HOME"

    $env:JULIA_DEPOT_PATH   = "$env:KOMPANION_DATA/julia"
    $env:JULIA_CONDAPKG_ENV = "$env:KOMPANION_DATA/CondaPkg"
}

function Setup-Racket() {
    param( [pscustomobject]$obj )
    $env:RACKET_HOME = Package-Path $obj
    Prepend-Path -Directory "$env:RACKET_HOME"
}

function Setup-Pandoc() {
    param( [pscustomobject]$obj )
    $env:PANDOC_HOME = Package-Path $obj
    Prepend-Path -Directory "$env:PANDOC_HOME"
}

function Setup-JabRef() {
    param( [pscustomobject]$obj )
    $env:JABREF_HOME = Package-Path $obj
    Prepend-Path -Directory "$env:JABREF_HOME"
}

function Setup-Inkscape() {
    param( [pscustomobject]$obj )
    $env:INKSCAPE_HOME = "$(Package-Path $obj)/bin"
    Prepend-Path -Directory "$env:INKSCAPE_HOME"
}

function Setup-MikTeX() {
    param( [pscustomobject]$obj )
    $env:MIKTEX_HOME = Package-Path $obj
    Prepend-Path -Directory "$env:MIKTEX_HOME"

    $path = "$env:MIKTEX_HOME/miktex-portable.cmd"
    Start-Process -FilePath $path -NoNewWindow

    Prepend-Path -Directory "$env:MIKTEX_HOME/texmfs/install/miktex/bin/x64\internal"
    Prepend-Path -Directory "$env:MIKTEX_HOME/texmfs/install/miktex/bin/x64"
}

function Setup-Elmer() {
    param( [pscustomobject]$obj )
    $env:ELMER_HOME = "$(Package-Path $obj)/bin"
    Prepend-Path -Directory "$env:ELMER_HOME"
}

function Setup-Gmsh() {
    param( [pscustomobject]$obj )
    $env:GMSH_HOME = "$(Package-Path $obj)"
    Prepend-Path -Directory "$env:GMSH_HOME/bin"
    Prepend-Path -Directory "$env:GMSH_HOME/lib"
    # TODO add to PYTHONPATH;JULIA_LOAD_PATH
}

# ---------------------------------------------------------------------------
# MAIN
# ---------------------------------------------------------------------------

function Kompanion-Config() {
    Get-Content -Path "$env:KOMPANION/kompanion.json" -Raw | ConvertFrom-Json
}

function Kompanion-Build() {
    Write-Host "Starting Kompanion setup!"
    $config = Kompanion-Config

    Handle-VSCode -Config $config.install.vscode
    Handle-7Z     -Config $config.install.sevenzip
    Handle-Git    -Config $config.install.git
    # Handle-Msys2 # XXX: not ready!

    if ($EnablePython) {
        $pyConfig = $config.install.python
        Conditional-Install $pyConfig
        Setup-Python $pyConfig

        $requirements = Kompanion-Path $pyConfig.requirements
        Piperish "install" "-r" $requirements
    }

    if ($EnableJulia)  {
        $jlConfig = $config.install.julia
        Conditional-Install $jlConfig
        Setup-Julia $jlConfig

        $jRun = "$env:JULIA_HOME/julia.exe"
        Start-Process -FilePath $jRun -ArgumentList "-e", "exit()" `
            -NoNewWindow -Wait -RedirectStandardOutput $KOMPANION_LOG
    }

    if ($EnableRacket) {
        $rkConfig = $config.install.racket
        Conditional-Install $rkConfig -Method "TAR"
        Setup-Racket $rkConfig
    }

    if ($EnableLaTeX) {
        Conditional-Install $config.install.pandoc
        Setup-Pandoc $config.install.pandoc

        Conditional-Install $config.install.jabref
        Setup-JabRef $config.install.jabref

        Conditional-Install $config.install.inkscape -Method "7Z"
        Setup-Inkscape $config.install.inkscape

        Handle-MikTeXSetup $config.install.miktexsetup
        Setup-MikTeX $config.install.miktex
    }

    if ($EnableElmer) {
        Conditional-Install $config.install.elmer
        Setup-Elmer $config.install.elmer
    }

    if ($EnableGmsh) {
        Conditional-Install $config.install.gmsh
        Setup-Gmsh $config.install.gmsh
    }
}

function Kompanion-Setup() {
    $config = Kompanion-Config
    Prepend-Path -Directory "$env:KOMPANION_BIN"

    Setup-VSCode
    Setup-Git

    if ($EnablePython) { Setup-Python $config.install.python }
    if ($EnableJulia)  { Setup-Julia  $config.install.julia }
    if ($EnableRacket) { Setup-Racket $config.install.racket }

    if ($EnableLaTeX) {
        Setup-Pandoc   $config.install.pandoc
        Setup-JabRef   $config.install.jabref
        Setup-Inkscape $config.install.inkscape
        Setup-MikTeX   $config.install.miktex
    }

    if ($EnableElmer) { Setup-Elmer $config.install.elmer }
    if ($EnableGmsh)  { Setup-Gmsh $config.install.gmsh }

    # TODO pull all submodules!
}

function Kompanion-Launch() {
    Kompanion-Setup

    Code.exe `
        --extensions-dir $env:VSCODE_EXTENSIONS `
        --user-data-dir  $env:VSCODE_SETTINGS  .
}

# ---------------------------------------------------------------------------
# MAIN
# ---------------------------------------------------------------------------

if ($RebuildOnStart) { Kompanion-Build }

Kompanion-Setup

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