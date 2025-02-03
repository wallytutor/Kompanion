# LaTeX and related

Although LaTeX is not mandatory, it is highly encouraged; otherwise, what is the point of doing any scientific computing and not publishing its results?

- Start by following the instructions provided [here](https://miktex.org/howto/portable-edition) to install MikTeX. Point the installation to a directory `miktex-portable` under `apps` and select *on-the-fly* installation of new packages.

- Consider installing the following additional software:

    - [JabRef](https://www.fosshub.com/JabRef.html)
    - [pandoc](https://github.com/jgm/pandoc/releases)
    - [inkscape](https://inkscape.org/release/1.4/windows/64-bit/)

- Globally install [`pip install Pygments`](https://pygments.org/) for enabling syntax highlight in LaTeX using `minted`; that is the most flexible highlighting method for adding code snippets to your documents.

- Also consider installing extension [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop) for automatic compilation in editor with built-in PDF visualization.

To append to `TEXMF` variable one can use the MiKTeX Console graphical interface and under `Settings > Directories` navigate and select the local path. Alternativelly on can add to `bin/apps/miktex-portable/texmfs/install/miktex/config/miktexstartup.ini` a line as `CommonRoots=C:/Path/To/Kompanion/bin/data/texmf` pointing to a directory implementing the project [TeX Directory Structure](https://miktex.org/kb/tds).

**NOTE:** If you prefer a dedicated LaTeX editor, you may wish to install [texstudio](https://www.texstudio.org/#download); some configuration of paths with the application may be required.

**IMPORTANT:** For a fully operational *Jupyter notebook* environment you need both `pandoc` and `inkscape`.
