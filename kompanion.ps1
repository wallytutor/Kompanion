# -*- powershell -*-

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
    [switch]$EnableHaskell,
    [switch]$EnableRacket,
    [switch]$EnableMLton,
    [switch]$EnableSMLNJ,
    [switch]$EnableLaTeX,
    [switch]$EnableElmer,
    [switch]$EnableGmsh
)

$env:KOMPANION      = "$PSScriptRoot"
$env:KOMPANION_BIN  = "$env:KOMPANION\bin"
$env:KOMPANION_DATA = "$env:KOMPANION\data"
$env:KOMPANION_PKG  = "$env:KOMPANION\pkg"
$env:KOMPANION_TEMP = "$env:KOMPANION\temp"
$env:KOMPANION_SET  = ""

$env:AUCHIMISTE_PATH = "$env:KOMPANION_PKG\AuChimiste.jl"
$env:MAJORDOME_PATH  = "$env:KOMPANION_PKG\python-majordome"
$env:STACK_ROOT      = "$env:KOMPANION_DATA\stack"
$env:PLTUSERHOME     = "$env:KOMPANION_DATA\racket"
$env:PLT_PKGDIR      = "$env:PLTUSERHOME\Racket\8.18\pkgs"

$KOMPANION_LOG = "$env:KOMPANION\log.kompanion.out"
$KOMPANION_ERR = "$env:KOMPANION\log.kompanion.err"

if ($EnableFull) {
    Write-Host "Enabling all features"
    $EnableLang  = $true
    $EnableSimu  = $true
    $EnableLaTeX = $true
}

if ($EnableLang) {
    Write-Host "Enabling all languages"
    $EnablePython  = $true
    $EnableJulia   = $true
    $EnableHaskell = $true
    $EnableRacket  = $true
    $EnableMLton   = $true
    $EnableSMLNJ   = $true
}

if ($EnableSimu) {
    Write-Host "Enabling all simulation tools"
    $EnableElmer = $true
    $EnableGmsh  = $true
}

# ---------------------------------------------------------------------------
# FEATURE SET
# ---------------------------------------------------------------------------

if (-not $env:KOMPANION_SET) {
    # FIXME: variable is not being ported from launch!
    # Write-Host "Preparing KOMPANION_SET"

    $env:KOMPANION_SET  = ""

    if($env:PYTHON_HOME -or $EnablePython) {
        $env:KOMPANION_SET += " -EnablePython"
    }
    if($env:JULIA_HOME -or $EnableJulia)  {
        $env:KOMPANION_SET += " -EnableJulia"
    }
    if($env:HASKELL_HOME -or $EnableHaskell) {
        $env:KOMPANION_SET += " -EnableHaskell"
    }
    if($env:RACKET_HOME -or $EnableRacket) {
        $env:KOMPANION_SET += " -EnableRacket"
    }
    if($env:RACKET_HOME -or $EnableSMLNJ) {
        $env:KOMPANION_SET += " -EnableSMLNJ"
    }
    if($env:MIKTEX_HOME  -or $EnableLaTeX) {
        $env:KOMPANION_SET += " -EnableLaTeX"
    }
    if($env:ELMER_HOME -or $EnableElmer) {
        $env:KOMPANION_SET += " -EnableElmer"
    }
    if($env:GMSH_HOME -or $EnableGmsh) {
        $env:KOMPANION_SET += " -EnableGmsh"
    }
}

# ---------------------------------------------------------------------------
# HELPERS
# ---------------------------------------------------------------------------

. "$env:KOMPANION\src\utilities.ps1"
. "$env:KOMPANION\src\builder.ps1"
. "$env:KOMPANION\src\initialize.ps1"
. "$env:KOMPANION\src\setup.ps1"
. "$env:KOMPANION\src\aliases.ps1"

# ---------------------------------------------------------------------------
# MAIN
# ---------------------------------------------------------------------------

if ($RebuildOnStart) { Start-KompanionSetup }

Initialize-Kompanion

Write-Output @"
Starting Kompanion from $PSScriptRoot!

Environment
-----------
KOMPANION             $env:KOMPANION
KOMPANION_BIN         $env:KOMPANION_BIN
KOMPANION_DATA        $env:KOMPANION_DATA
KOMPANION_SET         $env:KOMPANION_SET

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