# Kompanion

A portable toolbox setup for working in Scientific Computing under Windows.

## Usage

1. Add this directory to your `PATH` environment variable.
1. In a PowerShell terminal, navigate to your working directory.
1. Source the environment with `. kompanion.ps1 <Features>`.
1. Call `Kompanion-Launch` and keep the terminal open.

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
