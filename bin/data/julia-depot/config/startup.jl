# -*- coding: utf-8 -*-
using Pkg

function pluto(; port = 2505)
    # Launch Pluto without localhost address.
    # For more: https://plutojl.org/en/docs/configuration/
    session = Pluto.ServerSession()
    session.options.server.launch_browser = false
    session.options.server.port = port
    session.options.server.root_url = "http://127.0.0.1:$(port)/"
    Pluto.run(session)
end

function is_installed(name)
    return Base.find_package(name) !== nothing
end

function ensure_requirements(requirements)
    for package in requirements
        !is_installed(package) && Pkg.add(package)
    end
end

function package_candidate(path)
    test1 = isdir(path)
    test2 = endswith(path, ".jl")
    test3 = isfile(joinpath(path, "Project.toml"))
    return test1 && test2 && test3
end

function package_name(path)
    # XXX: assuming path doesn't end by a forward slash!
    return String(split(splitdir(path)[end], ".")[1])
end

function packages_update()
    old_value = get(ENV, "KOMPANION_UPDATE", "0")

    ENV["KOMPANION_UPDATE"] = "1"

    setup_loadpath()

    ENV["KOMPANION_UPDATE"] = old_value

    return nothing
end

function setup_loadpath(; rel = joinpath(@__DIR__, "../../../pkgs"))
    update = parse(Int64, get(ENV, "KOMPANION_UPDATE", "0")) >= 1
    pkgs = abspath(get(ENV, "KOMPANION_PKGS", rel))

    @info("""
    Loading local environment...

    - Update status (KOMPANION_UPDATE) ... $(update)
    - Local packages repository .......... $(pkgs)

    """)

    for candidate in readdir(pkgs)
        path = joinpath(pkgs, candidate)
        
        if package_candidate(path)
            name = package_name(path)

            if is_installed(name) && !update
                @info("Package `$(name)` already installed...")
                continue
            end

            Pkg.develop(; path=path)
        end
    end

    return nothing
end

ensure_requirements([
    "DrWatson",
    "IJulia",
    "Pluto",
    "OhMyREPL",
    "Revise",
])

setup_loadpath()

# atreplinit() do repl => see https://discourse.julialang.org/t/107969/5
if Base.isinteractive() || isdefined(Main, :IJulia) & Main.IJulia.inited
    try
        @eval begin
            using Pluto
            using OhMyREPL
            using Revise
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
