# -*- powershell -*-

function Invoke-CapturedCommand() {
    param( [string]$FilePath, [string[]]$ArgumentList )
    Start-Process -FilePath $FilePath -ArgumentList $ArgumentList `
        -NoNewWindow -Wait -RedirectStandardOutput $KOMPANION_LOG `
        -RedirectStandardError $KOMPANION_ERR
}

function Invoke-DownloadIfNeeded() {
    param ( [string]$URL, [string]$Output )

    if (Test-Path -Path $Output) {
        Write-Host "Skipping download of $URL..."
    } else {
        Write-Host "Downloading $URL as $Output"
        Start-BitsTransfer -Source $URL -Destination $Output
    }
}

function Invoke-UncompressIfNeeded() {
    param ( [string]$Source, [string]$Destination, [string]$Method = "ZIP" )

    if (Test-Path -Path $Destination) {
        Write-Host "Skipping extraction of $Source..."
    } else {
        Write-Host "Expanding $Source into $Destination"
        if ($Method -eq "ZIP") {
            Expand-Archive -Path $Source -DestinationPath $Destination
        }
        elseif ($Method -eq "7Z") {
            Invoke-CapturedCommand "7zr.exe" @("x", $Source , "-o$Destination")
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

function Invoke-InstallIfNeeded() {
    param( [pscustomobject]$Config, [string]$Method = "ZIP" )
    $output = Get-KompanionPath $Config.saveAs
    $path   = Get-KompanionPath $Config.path
    Invoke-DownloadIfNeeded -URL $Config.URL -Output $output
    Invoke-UncompressIfNeeded -Source $output -Destination $path -Method $Method
    return $path
}
