# -*- coding: utf-8 -*-

# TODO: make this configurable from CLI.
const KOMPANION_VERBOSE = false

const KOMPANION_PKGS = abspath(joinpath(@__DIR__, "../../../pkgs"))

#######################################################################
# module StartupHelper
#######################################################################

module StartupHelper

using Pkg

function is_installed(name)
    return Base.find_package(name) !== nothing
end

function is_project(path)
    return isfile(joinpath(path, "Project.toml"))
end

function maybe_package(path)
    return isdir(path) && endswith(path, ".jl") && is_project(path)
end

function package_name(path)
    endswith(path, r"/") && return package_name(path[1:end-1])
    
    # XXX: assuming path doesn't end by a forward slash!
    return String(split(splitdir(path)[end], ".")[1])
end

function ensure_minimal_requirements()
    open(joinpath(@__DIR__, "requirements.txt")) do file
        for package in eachline(file)
            startswith(package, "#") && continue

            try
                !is_installed(package) && Pkg.add(package)
            catch err
                @warn(err.msg)
            end
        end
    end
end

function setup_loadpath()
    ensure_minimal_requirements()

    update = parse(Int64, get(ENV, "KOMPANION_UPDATE", "0")) >= 1
    pkgs = abspath(get(ENV, "KOMPANION_PKGS", Main.KOMPANION_PKGS))

    Main.KOMPANION_VERBOSE && @info("""
    Loading local environment...

    - Update status (KOMPANION_UPDATE) ... $(update)
    - Local packages repository .......... $(pkgs)

    """)

    for candidate in readdir(pkgs)
        path = joinpath(pkgs, candidate)
        
        if maybe_package(path)
            name = package_name(path)

            if is_installed(name) && !update
                Main.KOMPANION_VERBOSE && let
                    @info("Package `$(name)` already installed...")
                end
                continue
            end

            Pkg.develop(; path=path)
        end
    end

    return nothing
end

end # (module StartupHelper)

#######################################################################
# module Kompanion
#######################################################################

module Kompanion

# using ..StartupHelper: setup_loadpath

Main.StartupHelper.setup_loadpath()

# atreplinit() do repl => see https://discourse.julialang.org/t/107969/5
# if Base.isinteractive() || (isdefined(Main, :IJulia) & Main.IJulia.inited
if Base.isinteractive() || isdefined(Main, :IJulia)
    try
        @eval begin
            using Pluto
            using OhMyREPL
            using Revise
            import IJulia.jupyterlab as jpt
        end
    catch err
        @warn "error while importing packages" err
    end

    # XXX: add a new option to Julia's REPL? using DrWatson
    # if isfile("Project.toml") && isfile("Manifest.toml")
    #     quickactivate(".")
    # end

    ENV["JULIA_EDITOR"] = "nvim"
end

function jupyterlab(; port=nothing)
    jpt(; dir=pwd(), detached=true, port)
    run(`jupyter notebook list`)
    return nothing
end

function pluto(; port = 2505)
    # Launch Pluto without localhost address.
    # For more: https://plutojl.org/en/docs/configuration/
    session = Pluto.ServerSession()
    session.options.server.launch_browser = false
    session.options.server.port = port
    session.options.server.root_url = "http://127.0.0.1:$(port)/"
    Pluto.run(session)
end

function packages_update()
    old_value = get(ENV, "KOMPANION_UPDATE", "0")

    ENV["KOMPANION_UPDATE"] = "1"

    Main.StartupHelper.setup_loadpath()

    ENV["KOMPANION_UPDATE"] = old_value

    return nothing
end

Main.KOMPANION_VERBOSE && @info("""\
Functionalities exposed by `Kompanion`:
- Kompanion.jupyterlab(; port=nothing)
- Kompanion.pluto(; port = 2505)
- Kompanion.packages_update()
""")
end # (module Kompanion)

@info("Running Julia $VERSION with Kompanion addons!")

#######################################################################
# EOF
#######################################################################