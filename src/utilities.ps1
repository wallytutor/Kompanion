# -*- powershell -*-

function Convert-ToBackSlash {
    param([string]$Path)
    return $Path -replace '/', '\'
}

function Get-KompanionPath() {
    param ( [string]$ChildPath )
    $path = Join-Path -Path $env:KOMPANION -ChildPath $ChildPath
    return Convert-ToBackSlash $path
}

function Get-PackagePath() {
    param( [pscustomobject]$obj )
    return Get-KompanionPath "$($obj.path)\$($obj.name)"
}

function Test-InPath() {
    param( [string]$Directory )

    $normalized = $Directory.TrimEnd('\')
    $filtered = ($env:Path -split ';' | ForEach-Object { $_.TrimEnd('\') })

    return $filtered -contains $normalized
}

function Print-Path() {
    return $env:Path -split ';'
}

function Add-ToPath() {
    param ( [string]$Directory )

    if (Test-Path -Path $Directory) {
        if (Test-InPath $Directory) {
            Write-Host "Skipping already sourced: $Directory"
        } else {
            $env:Path = "$(Convert-ToBackSlash $Directory);" + $env:Path
            Write-Host "Prepending to path: $Directory"
        }
    } else {
        Write-Host "Not prepeding missing path to environment: $Directory"
    }
}

function Enable-Module() {
    Write-Host "Sorry, WIP..."
}

function Show-ModuleList() {
    Write-Host "Sorry, WIP..."
}

function Piperish() {
    $pythonPath = "$env:PYTHON_HOME\python\python.exe"

    if (Test-Path -Path $pythonPath) {
        $argList = @("-m", "pip", "--trusted-host", "pypi.org",
                     "--trusted-host", "files.pythonhosted.org") + $args
        Invoke-CapturedCommand $pythonPath $argList
    } else {
        Write-Host "Python executable not found!"
    }
}

function Get-KompanionConfig() {
    $raw = Get-Content -Path "$env:KOMPANION_DATA\kompanion.json" -Raw
    return $raw | ConvertFrom-Json
}

function Start-Kompanion() {
    Code.exe `
        --extensions-dir $env:VSCODE_EXTENSIONS `
        --user-data-dir  $env:VSCODE_SETTINGS  .
}
