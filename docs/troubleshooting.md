# Troubleshooting

## Julia

For the proper functioning of Kompanion, both [Pluto](https://plutojl.org/) and [IJulia](https://julialang.github.io/IJulia.jl/stable/) need to be available. Generally they should be automatically installed when first launching Julia, but that may fail for many reasons and you might need to manually install them.

## Jupyter lab

Using `WPY64-31310` some warnings/errors were found when launching Jupyterlab. Apparently some packages are missing so that it can work with its full capabilities. You may overcome this by manually installing:

- ipyparallel
- nbclassic
- voila

## gmsh

Because it was chosen that SDK version of gmsh was more adapted to integrate Kompanion, if you want to be able to pin the executable to your taskbar you need to copy the DLL from its `lib/` directory to `bin/`. If you think you will not need Python/Julia interfaces of gmsh, then you can move the DLL instead to save ~80MB of disk.

## Graphviz

If the first time you run `dot` you get a message as

```text
There is no layout engine support for "dot"
Perhaps "dot -c" needs to be run (with installer's privileges) to register the plugins?
```

Simply run `dot -c` as suggested and it should work fine (without admin privileges).

## VS Code

- If installing local extensions (such as elmer-sif provided herein), consider using [Developer: Install Extension from Location](https://github.com/microsoft/vscode/issues/178667#issuecomment-1495625943) instead of placing it under `.vscode/extensions` manually.

- For installing extensions from within a VSCode terminal, rather than the main executable one must use `%VSCODE_HOME%\bin\Code.cmd`. Currently, Visual Studio Code's command-line interface doesn't directly support installing extensions from a local directory without packaging them into .vsix files. The recommended method is to package your extension into a .vsix file using vsce and then install it. 
