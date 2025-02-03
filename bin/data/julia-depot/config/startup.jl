# Launch Pluto without localhost address.
#
# For more: https://plutojl.org/en/docs/configuration/
#
using Pkg

try
    using Pluto
catch
    Pkg.add("Pluto")
    using Pluto
end

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

function setup_loadpath(; rel = "../../../pkgs/")
    pkgs = abspath(get(ENV, "KOMPANION_PKGS", rel))

    for candidate in readdir(pkgs)
        candidate = joinpath(pkgs, candidate)

        if package_candidate(candidate)
            Pkg.develop(; path=candidate)
        end
    end
end

setup_loadpath()
