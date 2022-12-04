function main()
    assigned = []
    # Open the puzzle input
    open("Day4.txt") do file
        assigned = readlines(file)
    end

    # Split out the assignments
    assigned = split.(assigned, ",")
    
    countfulloverlap = 0
    countpartialoverlap = 0
    
    # Find the fully and partially overlapping assignments
    for pair in assigned
        if (isfulloverlap(pair))
            countfulloverlap += 1
        end
        if (ispartialoverlap(pair))
            countpartialoverlap += 1
        end
    end

    println("Number of fully overlapping assignments: $(countfulloverlap)")
    println("Number of partially overlapping assignments: $(countpartialoverlap)")
end


function isfulloverlap(assigned)

    # Find assignments that are fully contained within another
    first = split(assigned[1], "-")
    second = split(assigned[2], "-")

    first = (parse(Int, first[1]), parse(Int, first[2]))
    second = (parse(Int, second[1]), parse(Int, second[2]))

    if ((first[1] <= second[1] && first[2] >= second[2]) || (first[1] >= second[1] && first[2] <= second[2]))
        return true
    end

    return false
end


function ispartialoverlap(assigned)

    # Identify if an assignment has partial overlap
    first = split(assigned[1], "-")
    second = split(assigned[2], "-")

    first = (parse(Int, first[1]), parse(Int, first[2]))
    second = (parse(Int, second[1]), parse(Int, second[2]))

    if ((first[2] >= second[1] && first[2] <= second[2]) || (first[1] <= second[2] && first[1] >= second[1]))
        return true
    elseif((second[2] >= first[1] && second[2] <= first[2]) || (second[1] <= first[2] && second[1] >= first[1]))
        return true
    end

    return false
end


main()
