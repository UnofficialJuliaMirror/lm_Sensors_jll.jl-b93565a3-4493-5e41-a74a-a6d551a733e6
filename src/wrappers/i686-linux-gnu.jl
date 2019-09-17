# Autogenerated wrapper script for lm_Sensors_jll for i686-linux-gnu
export libsensors, sensors

## Global variables
PATH = ""
LIBPATH = ""
LIBPATH_env = "LD_LIBRARY_PATH"

# Relative path to `libsensors`
const libsensors_splitpath = ["lib", "libsensors.so"]

# This will be filled out by __init__() for all products, as it must be done at runtime
libsensors_path = ""

# libsensors-specific global declaration
# This will be filled out by __init__()
libsensors_handle = C_NULL

# This must be `const` so that we can use it with `ccall()`
const libsensors = "libsensors.so.5"


# Relative path to `sensors`
const sensors_splitpath = ["bin", "sensors"]

# This will be filled out by __init__() for all products, as it must be done at runtime
sensors_path = ""

# sensors-specific global declaration
function sensors(f::Function; adjust_PATH::Bool = true, adjust_LIBPATH::Bool = true)
    global PATH, LIBPATH
    env_mapping = Dict{String,String}()
    if adjust_PATH
        if !isempty(get(ENV, "PATH", ""))
            env_mapping["PATH"] = string(ENV["PATH"], ':', PATH)
        else
            env_mapping["PATH"] = PATH
        end
    end
    if adjust_LIBPATH
        if !isempty(get(ENV, LIBPATH_env, ""))
            env_mapping[LIBPATH_env] = string(ENV[LIBPATH_env], ':', LIBPATH)
        else
            env_mapping[LIBPATH_env] = LIBPATH
        end
    end
    withenv(env_mapping...) do
        f(sensors_path)
    end
end


"""
Open all libraries
"""
function __init__()
    global prefix = abspath(joinpath(@__DIR__, ".."))

    # Initialize PATH and LIBPATH environment variable listings
    global PATH_list, LIBPATH_list
    global libsensors_path = abspath(joinpath(artifact"lm_Sensors", libsensors_splitpath...))

    # Manually `dlopen()` this right now so that future invocations
    # of `ccall` with its `SONAME` will find this path immediately.
    global libsensors_handle = dlopen(libsensors_path)
    push!(LIBPATH_list, dirname(libsensors_path))

    global sensors_path = abspath(joinpath(artifact"lm_Sensors", sensors_splitpath...))

    push!(PATH_list, dirname(sensors_path))
    # Filter out duplicate and empty entries in our PATH and LIBPATH entries
    filter!(!isempty, unique!(PATH_list))
    filter!(!isempty, unique!(LIBPATH_list))
    global PATH = join(PATH_list, ':')
    global LIBPATH = join(LIBPATH_list, ':')

    # Add each element of LIBPATH to our DL_LOAD_PATH (necessary on platforms
    # that don't honor our "already opened" trick)
    #for lp in LIBPATH_list
    #    push!(DL_LOAD_PATH, lp)
    #end
end  # __init__()

