### PARAMETERS

param (
    [string]$TeXName = "Kompanion",
    [int]$CleanLevel = 2
)

if ($TeXName -eq "") {
    throw "Output file name is invalid: '$TeXName'."
}

### CONVERT

pandoc                                 `
    preamble.md                        `
    setup-general.md                   `
    setup-languages.md                 `
    recommended.md                     `
    troubleshooting.md                 `
    --metadata-file=conf/metadata.yaml `
    --template=conf/template.tex       `
    --biblatex --pdf-engine=xelatex    `
    -o "${TeXName}.tex"

### BUILD

xelatex "${TeXName}.tex"
xelatex "${TeXName}.tex"
xelatex "${TeXName}.tex"

### CLEAN

if ($CleanLevel -gt 0) {
    $rmpaths = @("*.aux", "*.bbl", "*.bcf", "*.blg", "*.run.xml", "*.toc")
    Remove-Item $rmpaths -Recurse -Force -ErrorAction SilentlyContinue
}

if ($CleanLevel -gt 1) {
    $rmpaths = @("*.log", "*.tex")
    Remove-Item $rmpaths -Recurse -Force -ErrorAction SilentlyContinue
}

### EOF