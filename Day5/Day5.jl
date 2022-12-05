function main()
    # Initial crate positions for directions
    crates = Array[
        ['D','L','J','R','V','G','F'],['T','P','M','B','V','H','J','S'],['V','H','M','F','D','G','P','C'],
        ['M','D','P','N','G','Q'],['J','L','H','N','F'],['N','F','V','Q','D','G','T','Z'],['F','D','B','L'],
        ['M','J','B','S','V','D','N'],['G','L','D']
    ]

    # Read procedures from text file
    procedures = []
    open("Day5.txt") do file
        procedures = readlines(file)
    end

    for procedure in procedures
        # Part 1 solution
        movecrate!(crates, procedure)
        # Part 2 solution
        #movecrates!(crates, procedure)
    end

    # Which crate is on top of the final stacks
    for stack in crates
        print(stack[end])
    end
end


function movecrate!(crates, procedure)
    #  Move a single crate at a time, part 1
    temp = split(procedure, " ")
    
    cratestomove = parse(Int, temp[2])
    fromlocation = parse(Int, temp[4])
    tolocation = parse(Int, temp[6])

    if (cratestomove > 0)
        append!(crates[tolocation], pop!(crates[fromlocation]))
        cratestomove -= 1
        movecrate!(crates, "move $(cratestomove) from $(fromlocation) to $(tolocation)")
    else
        return crates
    end
end


function movecrates!(crates, procedure)
    # Moves multiple crates at a time, part 2
    temp = split(procedure, " ")

    cratestomove = parse(Int, temp[2])
    fromlocation = parse(Int, temp[4])
    tolocation = parse(Int, temp[6])

    startindex = length(crates[fromlocation]) - cratestomove + 1
    endindex = length(crates[fromlocation])

    append!(crates[tolocation], crates[fromlocation][startindex:endindex])
    
    moves = (length(crates[fromlocation]) - cratestomove + 1)
    deleteat!(crates[fromlocation], startindex:endindex)

    return crates
end

main()
