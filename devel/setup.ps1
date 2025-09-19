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

function Handle-WinPython() {
    $URL = "https://github.com/winpython/winpython"
    $URL = "$URL//releases/download/17.2.20250831/WinPython64-3.13.7.0dotb4.zip"
    Handle-Zip-Install -URL $URL `
        -Output "$PSScriptRoot/temp/python.zip" `
        -Destination "$PSScriptRoot/bin/python"
}

function Handle-Julia() {
    $URL = "https://julialang-s3.julialang.org"
    $URL = "$URL/bin/winnt/x64/1.11/julia-1.11.7-win64.zip"
    Handle-Zip-Install -URL $URL `
        -Output "$PSScriptRoot/temp/julia.zip" `
        -Destination "$PSScriptRoot/bin/julia"
}

function Handle-Racket() {
    $URL = "https://download.racket-lang.org"
    $URL = "$URL/releases/8.18/installers/racket-minimal-8.18-x86_64-win32-cs.tgz"
    Handle-Tar-Install -URL $URL `
        -Output "$PSScriptRoot/temp/racket.tgz" `
        -Destination "$PSScriptRoot/bin/racket"
}

# ---------------------------------------------------------------------------
# MAIN
# ---------------------------------------------------------------------------

function Main() {
    Write-Host "Starting Kompanion setup!"
    Handle-VSCode
    # Handle-Msys2 # XXX: not ready!
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