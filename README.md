# Kompanion

A portable toolbox setup for working in Scientific Computing under Windows.

## Usage

For installation of desired packages (before first use), run `. kompanion.ps1 -RebuildOnStart <Features>`.

The simplest way to isolate the environment for a single package is to proceed as per the following instructions; please notice that doing so you can have only a single VSCode instance running, as launching other instances affect the environment variables for all (breaking isolation).

1. Add this directory to your `PATH` environment variable.
1. In a PowerShell terminal, navigate to your working directory.
1. Source the environment with `. kompanion.ps1 <Features>`.
1. Call `Start-Kompanion` and keep the terminal open.

In the source phase, `<Features>` may take the following values:

| Flag              | Description |
|:------------------|:------------|
| `-RebuildOnStart` | Force rebuild/installation of packages
| `-EnableFull`     | Enable all supported features
| `-EnableLang`     | Enable all programming languages
| `-EnableSimu`     | Enable all simulation tools
| `-EnablePython`   | Enable Python
| `-EnableJulia`    | Enable Julia
| `-EnableRacket`   | Enable Racket
| `-EnableLaTeX`    | Enable LaTeX (extended) toolkit
| `-EnableElmer`    | Enable Elmer Multiphysics
| `-EnableGmsh`     | Enable Gmsh

## To-do

The following aim at flattening the project of at least one level:

- [ ] Refactor documentation for new version.
- [ ] Update Git submodules at `.gitmodules` and under `.git` directory at relevant locations.
- [ ] Split the `Tested packages` of `docs/preamble.md` into sections for better management.
- [ ] `kompanion.ps1` could be split into a library, initialization functions, setup, and start sub-modules. Consider refactoring.

## How to add a new package?

- Create an entry under `"install"` dictionary of `kompanion.json`; for most software provided in compressed format that means simply something as:

```json
"packagename": {
    "name": "extractionname",
    "URL": "https://path/to/some/zip.zip",
    "saveAs": "temp/packagename.zip",
    "path": "bin/packagename"
},
```

- If the package has a conditional installation, add a `param` to the top of `kompanion.ps1` for handling it if necessary; also think about updating the global flag handlers on the top of the file, if applicable.

- Create a `Initialize-PackageName()` function to `kompanion.ps1`; this must at least handle adding the package and relevant libraries to the path.

- Add the package setup instructions to `Start-KompanionSetup` in `kompanion.ps1`; if the software has conditional installation, identify the right place depending on the flag it is associated to.

- Add the initialization function call to `Initialize-Kompanion` (also thinking about the conditionals discussed above).
