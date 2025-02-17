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
