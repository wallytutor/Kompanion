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
# HELPERS
# ---------------------------------------------------------------------------

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

# ---------------------------------------------------------------------------
# SETUP
# ---------------------------------------------------------------------------

function Setup-VSCode() {
    $env:VSCODE_HOME = "$KOMPANION_BIN/vscode"
    Prepend-Path -Directory "$env:VSCODE_HOME"

    $env:VSCODE_EXTENSIONS = "$KOMPANION_DATA/vscode/extensions"
    $env:VSCODE_SETTINGS   = "$KOMPANION_DATA/vscode/user-data"
}

function Setup-Git() {
    $env:GIT_HOME = "$KOMPANION_BIN/git"
    Prepend-Path -Directory "$env:GIT_HOME/cmd"
}

function Setup-Python() {
    $env:PYTHON_HOME = "$KOMPANION_BIN/python/$KOMPANION_NAME_PYTHON/python"
    Prepend-Path -Directory "$env:PYTHON_HOME/Scripts"
    Prepend-Path -Directory "$env:PYTHON_HOME"
}

function Setup-Julia() {
    $env:JULIA_HOME = "$KOMPANION_BIN/julia/$KOMPANION_NAME_JULIA/bin"
    Prepend-Path -Directory "$env:JULIA_HOME"

    $env:JULIA_DEPOT_PATH   = "$KOMPANION_DATA/julia"
    $env:JULIA_CONDAPKG_ENV = "$KOMPANION_DATA/CondaPkg"
}

function Setup-Racket() {
    $env:RACKET_HOME = "$KOMPANION_BIN/racket/$KOMPANION_NAME_RACKET"
    Prepend-Path -Directory "$env:RACKET_HOME"
}

# ---------------------------------------------------------------------------
# MAIN
# ---------------------------------------------------------------------------

function Setup-Main() {
    Prepend-Path -Directory "$KOMPANION_BIN"

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
KOMPANION_BIN     $KOMPANION_BIN
KOMPANION_DATA    $KOMPANION_DATA

Other paths
-----------
VSCODE_HOME       $env:VSCODE_HOME
VSCODE_EXTENSIONS $env:VSCODE_EXTENSIONS
VSCODE_SETTINGS   $env:VSCODE_SETTINGS
GIT_HOME          $env:GIT_HOME
"@

Code.exe `
    --extensions-dir $env:VSCODE_EXTENSIONS `
    --user-data-dir  $env:VSCODE_SETTINGS  .

# ---------------------------------------------------------------------------
# EOF
# ---------------------------------------------------------------------------