# LaTeX and related

Although LaTeX is not mandatory, it is highly encouraged; otherwise, what is the point of doing any scientific computing and not publishing its results? Also for a fully operational *Jupyter notebook* environment you need both `pandoc` and `inkscape`. 

- [MikTeX](https://miktex.org/howto/portable-edition)
- [texstudio](https://www.texstudio.org/#download)
- [JabRef](https://www.fosshub.com/JabRef.html?dwl=JabRef-5.13.msi)
- [pandoc](https://pandoc.org/installing.html)
- [inkscape](https://inkscape.org/release/inkscape-1.3.2/windows/64-bit/)

Globally install [`pip install Pygments`](https://pygments.org/) for enabling syntax highlight in LaTeX using `minted`; that is the most flexible highlighting method for adding code snippets to your documents.

To append to `TEXMF` variable one can use the MiKTeX Console graphical interface and under `Settings > Directories` navigate and select the local path. Alternativelly on can add to `bin/<miktex-dir>/texmfs/install/miktex/config/miktexstartup.ini` a line as

```ini
CommonRoots=C:/Path/To/Local/TeX/Tree
```

pointing to a directory implementing the user's [TeX Directory Structure](https://miktex.org/kb/tds).
