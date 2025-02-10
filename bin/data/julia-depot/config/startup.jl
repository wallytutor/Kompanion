# Launch Pluto without localhost address.
#
# For more: https://plutojl.org/en/docs/configuration/
#
using Pkg

is_installed(name) = Base.find_package(name) !== nothing

!is_installed("Pluto") && Pkg.add("Pluto")

using Pluto

function pluto(; port = 2505)
    session = Pluto.ServerSession()
    session.options.server.launch_browser = false
    session.options.server.port = port
    session.options.server.root_url = "http://127.0.0.1:$(port)/"
    Pluto.run(session)
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
end

setup_loadpath()
