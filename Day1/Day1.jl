# Part 1
# Read the data from file
open("Day1.txt") do file
    rows = readlines(file)

    prevHigh = 0
    current = 0
    for row in rows
        if(row != "")
            current += parse(Int, row)
        elseif(current > prevHigh)
            prevHigh = current
            current = 0
        else
            current = 0
        end
    end
    if(current > prevHigh)
        prevHigh = current
    end

    println("Highest amount of calories with an elf: $(prevHigh)")
end

# Part 2
# Read the data from file
open("Day1.txt") do file
    rows = readlines(file)

    cals = Vector{Int64}()
    current = 0
    for row in rows
        if(row != "")
            current += parse(Int, row)
        else
            append!(cals, current)
            current = 0
        end
    end
    # Add last sum to the vector
    append!(cals, current)

    # Sort the calories vector in reverse order and sum the first three
    println("Total calories held by top 3 elves: $(sum(first(sort!(cals, rev = true), 3)))")
end
