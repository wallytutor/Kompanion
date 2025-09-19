# kompanion.psw

# ---------------------------------------------------------------------------
# GLOBAL
# ---------------------------------------------------------------------------

param (
    [switch]$EnablePython = $true,
    [switch]$EnableJulia  = $true,
    [switch]$EnableRacket = $true
)

$KOMPANION_BIN  = "$PSScriptRoot/bin"
$KOMPANION_DATA = "$PSScriptRoot/data"

$KOMPANION_NAME_PYTHON = "WPy64-3170b4"
$KOMPANION_NAME_JULIA  = "julia-1.11.7"
$KOMPANION_NAME_RACKET = "racket"

# ---------------------------------------------------------------------------
# SETUP
# ---------------------------------------------------------------------------

function Test-InPath {
    param(
        [string]$Directory
    )

    $normalized = $Directory.TrimEnd('\')
    return ($env:Path -split ';' | ForEach-Object { $_.TrimEnd('\') }) -contains $normalized
}

function Prepend-Path() {
    param (
        [string]$Path
    )

    if (Test-Path -Path $Path) {
        if (Test-InPath $Path) {
            Write-Host "Skipping $Path already sourced..."
        } else {
            Write-Host "Prepending $Path to path..."
            $env:Path = "$Path;" + $env:Path
        }
    } else {
        Write-Host "Not prepeding missing path $Path to environment"
    }
}

function Setup-VSCode() {
    $env:VSCODE_HOME = "$KOMPANION_BIN/vscode"
    Prepend-Path -Path "$env:VSCODE_HOME"

    $env:VSCODE_EXTENSIONS = "$KOMPANION_DATA/vscode/extensions"
    $env:VSCODE_SETTINGS   = "$KOMPANION_DATA/vscode/user-data"
}

function Setup-Git() {
    $env:GIT_HOME = "$KOMPANION_BIN/git"
    Prepend-Path -Path "$env:GIT_HOME/cmd"
}

function Setup-Python() {
    $env:PYTHON_HOME = "$KOMPANION_BIN/python/$KOMPANION_NAME_PYTHON/python"
    Prepend-Path -Path "$env:PYTHON_HOME/Scripts"
    Prepend-Path -Path "$env:PYTHON_HOME"
}

function Setup-Julia() {
    $env:JULIA_HOME = "$KOMPANION_BIN/julia/$KOMPANION_NAME_JULIA/bin"
    Prepend-Path -Path "$env:JULIA_HOME"

    $env:JULIA_DEPOT_PATH   = "$KOMPANION_DATA/data"
    $env:JULIA_CONDAPKG_ENV = "$KOMPANION_DATA/CondaPkg"
}

function Setup-Racket() {
    $env:RACKET_HOME = "$KOMPANION_BIN/racket/$KOMPANION_NAME_RACKET"
    Prepend-Path -Path "$env:RACKET_HOME"
}

# ---------------------------------------------------------------------------
# MAIN
# ---------------------------------------------------------------------------

function Setup-Main() {
    Prepend-Path -Path "$KOMPANION_BIN"

    Setup-VSCode
    Setup-Git

    if ($EnablePython) { Setup-Python }
    if ($EnableJulia)  { Setup-Julia }
    if ($EnableRacket) { Setup-Racket }
}

# ---------------------------------------------------------------------------
# MAIN
# ---------------------------------------------------------------------------

Setup-Main

Write-Output @"
Starting Kompanion from $PSScriptRoot!

Environment
-----------
KOMPANION_BIN   $KOMPANION_BIN
KOMPANION_DATA  $KOMPANION_DATA
"@

Code.exe `
    --extensions-dir $env:VSCODE_EXTENSIONS `
    --user-data-dir  $env:VSCODE_SETTINGS  .

# ---------------------------------------------------------------------------
# EOF
# ---------------------------------------------------------------------------