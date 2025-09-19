# setup.ps1

# ---------------------------------------------------------------------------
# CORE
# ---------------------------------------------------------------------------

function Conditional-Download() {
    param (
        [string]$URL,
        [string]$Output
    )

    if (Test-Path -Path $Output) {
        Write-Host "Skipping download of $URL..."
    } else {
        Write-Host "Downloading $URL as $Output"
        Start-BitsTransfer -Source $URL -Destination $Output
    }
}

# TODO create Conditional-Extract with a parameter for the kind
function Conditional-Unzip() {
    param (
        [string]$Source,
        [string]$Destination
    )
    
    if (Test-Path -Path $Destination) {
        Write-Host "Skipping extraction of $Source..."
    } else {
        Write-Host "Expanding $Source intp $Destination"
        Expand-Archive -Path $Source -DestinationPath $Destination
    }
}

function Conditional-Untar() {
    param (
        [string]$Source,
        [string]$Destination
    )
    
    if (Test-Path -Path "$Destination") {
        Write-Host "Skipping extraction of $Source..."
    } else {
        Write-Host "Expanding $Source intp $Destination"
        New-Item -Path "$Destination" -ItemType Directory
        tar -xzf $Source -C $Destination
    }
}

function Handle-Zip-Install() {
    param (
        [string]$URL,
        [string]$Output,
        [string]$Destination
    )

    Conditional-Download -URL $URL -Output $Output
    Conditional-Unzip -Source $Output -Destination $Destination
}

function Handle-Tar-Install() {
    param (
        [string]$URL,
        [string]$Output,
        [string]$Destination
    )

    Conditional-Download -URL $URL -Output $Output
    Conditional-Untar -Source $Output -Destination $Destination
}

# ---------------------------------------------------------------------------
# DOWNLOADS
# ---------------------------------------------------------------------------

function Handle-VSCode() {
    $URL = "https://update.code.visualstudio.com"
    $URL = "$URL/latest/win32-x64-archive/stable"
    Handle-Zip-Install -URL $URL -Output "temp/vscode.zip" -Destination "bin/vscode"
}

function Handle-7Z() {

}

function Handle-Git() {
    $URL = "https://github.com/git-for-windows/git/releases/download"
    $URL = "$URL/v2.51.0.windows.1/PortableGit-2.51.0-64-bit.7z.exe"
    # TODO finish because not ZIP
    # Handle-Zip-Install -URL $URL -Output "temp/git.zip" -Destination "bin/git"
}

function Handle-WinPython() {
    $URL = "https://github.com/winpython/winpython"
    $URL = "$URL//releases/download/17.2.20250831/WinPython64-3.13.7.0dotb4.zip"
    Handle-Zip-Install -URL $URL -Output "temp/python.zip" -Destination "bin/python"
}

function Handle-Julia() {
    $URL = "https://julialang-s3.julialang.org"
    $URL = "$URL/bin/winnt/x64/1.11/julia-1.11.7-win64.zip"
    Handle-Zip-Install -URL $URL -Output "temp/julia.zip" -Destination "bin/julia"
}

function Handle-Racket() {
    $URL = "https://download.racket-lang.org"
    $URL = "$URL/releases/8.18/installers/racket-minimal-8.18-x86_64-win32-cs.tgz"
    Handle-Tar-Install -URL $URL -Output "temp/racket.tgz" -Destination "bin/racket"
}

# ---------------------------------------------------------------------------
# MAIN
# ---------------------------------------------------------------------------

function Main() {
    Write-Host "Starting Kompanion setup!"
    Handle-VSCode
    Handle-7Z
    Handle-Git
    Handle-WinPython
    Handle-Julia
    Handle-Racket
}

Main

# ---------------------------------------------------------------------------
# EOF
# ---------------------------------------------------------------------------