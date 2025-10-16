# -*- powershell -*-

function Start-KompanionSetup() {
    Write-Host "Starting Kompanion setup!"
    $config = Get-KompanionConfig


    $path = $env:KOMPANION_BIN
    if (!(Test-Path $path)) { New-Item -ItemType Directory -Path $path }

    $path = $env:KOMPANION_TEMP
    if (!(Test-Path $path)) { New-Item -ItemType Directory -Path $path }


    # -----------------------------------------------------------------------
    # VSCODE
    # -----------------------------------------------------------------------

    & {
        $trash = Invoke-InstallIfNeeded $config.install.vscode
        Initialize-VSCode $config.install.vscode

        # TODO failing because of certificate
        # foreach ($pkg in $Config.requirements) {
        #     $cmdPath = "$env:VSCODE_HOME\bin\Code.cmd"
        #     $argList = @("--extensions-dir", $env:VSCODE_EXTENSIONS,
        #                  "--user-data-dir",   $env:VSCODE_SETTINGS,
        #                  "--install-extension", $pkg)
        #     Invoke-CapturedCommand $cmdPath $argList
        # }
    }

    # -----------------------------------------------------------------------
    # 7-zip
    # -----------------------------------------------------------------------

    & {
        $output  = Get-KompanionPath $config.install.sevenzip.saveAs
        $path    = Get-KompanionPath $config.install.sevenzip.path
        Invoke-DownloadIfNeeded -URL $config.install.sevenzip.URL -Output $output

        if (Test-Path -Path $path) {
            Write-Host "Skipping extraction of $output..."
        } else {
            Write-Host "Expanding $output into $path"
            Copy-Item -Path $output -Destination $path
        }
    }

    # -----------------------------------------------------------------------
    # Git
    # -----------------------------------------------------------------------

    & {
        $output  = Get-KompanionPath $config.install.git.saveAs
        $path    = Get-KompanionPath $config.install.git.path
        Invoke-DownloadIfNeeded -URL $config.install.git.URL -Output $output

        if (Test-Path -Path $path) {
            Write-Host "Skipping extraction of $output..."
        } else {
            Write-Host "Expanding $output into $path"
            Invoke-CapturedCommand $output @("-y", "-o$path")
        }

        Initialize-Git $config.install.git
    }

    # -----------------------------------------------------------------------
    # MSYS2
    # -----------------------------------------------------------------------

    & {
        # $output = Get-KompanionPath $$config.install.msys2.saveAs
        # $path   = Get-KompanionPath $$config.install.msys2.path
        # Invoke-DownloadIfNeeded -URL $$config.install.msys2.URL -Output $output

        # if (Test-Path -Path $path) {
        #     Write-Host "Skipping extraction of $output..."
        # } else {
        #     Write-Host "Expanding $output into $path"
        #     $argList = @("in", "--confirm-command", "--accept-messages"
        #                  "--root", "$path")
        #     Invoke-CapturedCommand $output $argList
        # }

        # $bash = Get-KompanionPath "bin\msys2\usr\bin\bash"
        # $argList = @("-lc", "'pacman -Syu --noconfirm'")
        # $argList = @("-lc", "'pacman -Su --noconfirm'")
        # bin\msys2\usr\bin\bash -lc "pacman -Syu --noconfirm"
        # bin\msys2\usr\bin\bash -lc "pacman -Su --noconfirm"
        # pacman-key --init && pacman-key --populate msys2
        # pacman -Syuu && pacman -S bash coreutils make gcc p7zip
        # pacman -Sy --noconfirm; pacman -S --noconfirm p7zip
    }

    # -----------------------------------------------------------------------
    # LESSMSI
    # -----------------------------------------------------------------------

    $trash = Invoke-InstallIfNeeded $config.install.lessmsi
    Initialize-Lessmsi $config.install.lessmsi

    # -----------------------------------------------------------------------
    # NEOVIM
    # -----------------------------------------------------------------------

    $trash = Invoke-InstallIfNeeded $config.install.neovim
    Initialize-Neovim $config.install.neovim

    # -----------------------------------------------------------------------
    # MODULES
    # -----------------------------------------------------------------------

    if ($EnableLaTeX) {
        $trash = Invoke-InstallIfNeeded $config.install.pandoc
        Initialize-Pandoc $config.install.pandoc

        $trash = Invoke-InstallIfNeeded $config.install.jabref
        Initialize-JabRef $config.install.jabref

        $trash = Invoke-InstallIfNeeded $config.install.inkscape -Method "7Z"
        Initialize-Inkscape $config.install.inkscape

        $path = Invoke-InstallIfNeeded $config.install.miktexsetup
        $path = "$path\miktexsetup_standalone.exe"

        $pkgData = Get-KompanionPath $config.install.miktexsetup.data
        $miktex  = Get-PackagePath $config.install.miktex

        if (Test-Path -Path $pkgData) {
            Write-Host "Skipping download of package data to $pkgData..."
        } else {
            Write-Host "Downloading MikTex data to $pkgData"
            # XXX: finally it works without this:
            #  "--remote-package-repository", $Config.repo,
            $argList = @("download", "--package-set", "basic",
                        "--local-package-repository", $pkgData)
            Invoke-CapturedCommand $path $argList
        }

        if (Test-Path -Path $miktex) {
            Write-Host "Skipping install of MikTex to $miktex..."
        } else {
            Write-Host "Installing MikTex data to $miktex"
            $argList = @("install", "--package-set", "basic",
                        "--local-package-repository", $pkgData,
                        "--portable", $miktex)
            Invoke-CapturedCommand $path $argList
        }

        Initialize-MikTeX $config.install.miktex
    }

    if ($EnableElmer) {
        $trash = Invoke-InstallIfNeeded $config.install.elmer
        Initialize-Elmer $config.install.elmer
    }

    if ($EnableGmsh) {
        $trash = Invoke-InstallIfNeeded $config.install.gmsh
        Initialize-Gmsh $config.install.gmsh
    }

    # XXX: languages come last because some packages might override
    # them (especially Python that is used everywhere).
    if ($EnablePython) {
        $pyConfig = $config.install.python
        $trash = Invoke-InstallIfNeeded $pyConfig
        Initialize-Python $pyConfig

        $requirements = Get-KompanionPath $pyConfig.requirements
        Piperish "install" "-r" $requirements
    }

    if ($EnableJulia)  {
        $jlConfig = $config.install.julia
        $trash = Invoke-InstallIfNeeded $jlConfig
        Initialize-Julia $jlConfig

        Invoke-CapturedCommand "$env:JULIA_HOME\bin\julia.exe" @("-e", "exit()")
    }

    if ($EnableHaskell) {
        $hsConfig = $config.install.stack
        $trash = Invoke-InstallIfNeeded $hsConfig -Method "ZIP"
        Initialize-Haskell $hsConfig

        $stackPath = "$env:HASKELL_HOME\stack.exe"
        Invoke-CapturedCommand $stackPath @("setup")

        $content = Get-Content -Raw -Path "$env:KOMPANION_DATA\stack-config.yaml"
        $content = $content -replace '__STACK_ROOT__', $env:STACK_ROOT
        Set-Content -Path "$env:STACK_ROOT\config.yaml" -Value $content
    }

    if ($EnableRacket) {
        $rkConfig = $config.install.racket
        $trash = Invoke-InstallIfNeeded $rkConfig -Method "TAR"
        Initialize-Racket $rkConfig
    }

    if ($EnableMLton) {
        $mlConfig = $config.install.mlton
        $trash = Invoke-InstallIfNeeded $mlConfig -Method "TAR"
        Initialize-MLton $mlConfig
    }

    if ($EnableSMLNJ) {
        $smlConfig = $config.install.smlnj
        $trash = Invoke-InstallIfNeeded $smlConfig -Method "MSI"
        Initialize-SMLNJ $smlConfig
    }
}
