open("Day7.txt", "r") do file
    global file_dir = Dict("/" => Dict())
    global current_dir = ["/"] 
    global max_depth = 1

    while ! eof(file)
        line = readline(file)
        # Update current directory
        if startswith(line, "\$ cd")  
            new_dir = line[6:end]
            if new_dir == "/"
                current_dir = ["/"]
            elseif new_dir == ".."
                pop!(current_dir)
            else
                local_dir = file_dir
                for dir in current_dir
                    local_dir = local_dir[dir]
                end
                # Add a new directory
                if !(new_dir in keys(local_dir))
                    local_dir[new_dir] = Dict()
                end
                push!(current_dir, new_dir)
                max_depth = max(max_depth, length(current_dir))
            end

        # List the files in the current directory
        elseif startswith(line, "\$ ls") 
            global local_dir = file_dir
            for dir in current_dir
                local_dir = local_dir[dir]
            end
                  
        else  
            # Add files to the current directory
            line_vals = split(line)
            if line_vals[1] == "dir" 
                # Directory added
                continue 
            else
                local_dir[line_vals[2]] = line_vals[1]
            end
        end
    end
    println("Maximum folder depth: $max_depth")
end

# Recursive function to find the size of each directory
function find_sizes(dict, sizes)
    local dict_size = 0
    for (key, value) in dict
        if value isa Dict
            find_sizes(value, sizes)
            try
                global dict[key] = string(sizes[end])
            catch 
                @warn("May be raised at top level if unable to convert dict to string sum. 
                       Not an issue if only raised once.")
                break
            end
        end
        # Update the value after change by summation
        value = dict[key] 
        if value isa AbstractString
            dict_size += parse(Int, value)
        else
            println((value, typeof(value)))
            @warn("Found dict entry $value of unrecognised type $(typeof(value))")
        end
    end
    push!(sizes, dict_size)
end

sizes_list = []
dir_sizes = find_sizes(deepcopy(file_dir), sizes_list)

# Find the summed size of the small directories (Part 1)
part1limit = 100000
part1 = filter((x) -> x < part1limit, dir_sizes) 

# Find the smallest directory that will free up enough room (Part 2)
total_size = 70000000; req_space = 30000000
req_to_delete = req_space - (total_size - maximum(dir_sizes))
part2 = sort(filter((x) -> x > req_to_delete, dir_sizes))

# What are the answers
println("Summed size of small dirs: $(sum(part1))")
println("Size of smallest dir that gives enough storage: $(part2[1])")
