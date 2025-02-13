# Troubleshooting

## Julia

- For the proper functioning of Kompanion, both [Pluto](https://plutojl.org/) and [IJulia](https://julialang.github.io/IJulia.jl/stable/) need to be available. Generally they should be automatically installed when first launching Julia, but that may fail for many reasons and you might need to manually install them.

## Jupyter lab

Using `WPY64-31310` some warnings/errors were found when launching Jupyterlab. Apparently some packages are missing so that it can work with its full capabilities. You may overcome this by manually installing:

- ipyparallel
- nbclassic
- voila
