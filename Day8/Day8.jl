function day8()
    lines = ""
    open("Day8.txt") do file
        lines = readlines(file)
    end

    rows = length(lines)
    columns = length(lines[1])

    # Let's try a matrix?
    grid = Array{Int16}(undef, rows, columns)

    for row in 1:rows
        for col in 1:columns
            grid[row, col] = parse(Int16, lines[row][col])
        end
    end

    # Look through all of the trees and see what's visible (part 1)
    treesseen = 0
    gridtransposed = transpose(grid)
    for row in 1:rows
        for col in 1:columns
            # Transpose the matrix to look from the sides
            if (isvisiblefrombelow(grid, (row, col)) 
                    || isvisiblefromabove(grid, (row, col)) 
                    || isvisiblefrombelow(gridtransposed, (col, row)) 
                    || isvisiblefromabove(gridtransposed, (col, row)))
                    treesseen += 1
            end
        end
    end
    println("Number of trees visible from outside: $(treesseen)")

    # Find the highest score (part 2)
    highscore = 0
    for row in 1:rows
        for col in 1:columns
            # Transposing to get the side views again
            scenicscore = gettopscore(grid, (row, col)) * getbottomscore(grid, (row, col)) * gettopscore(gridtransposed, 
            (col, row)) * getbottomscore(gridtransposed, (col, row))
            
            if (scenicscore > highscore)
                highscore = scenicscore
            end
        end
    end

    println("Highest scenic score: $(highscore)")
end

# If it's in the top row we can see it from above
function isvisiblefromabove(grid, location)
    row = location[1]
    col = location[2]
    if (row == 1)
        return true
    end

    for index in 1:(row-1)
        if (grid[row, col] <= grid[index, col])
            return false
        end
    end

    return true
end

# If it's in the bottom row we can see it from below
function isvisiblefrombelow(grid, location)
    row = location[1]
    col = location[2]
    if (row == size(grid)[1])
        return true
    end

    for index in (row+1):size(grid)[1]
        if (grid[row, col] <= grid[index, col])
            return false
        end
    end

    return true
end

# If it's in the top row, the score looking up is 0
function gettopscore(grid, location)
    row = location[1]
    col = location[2]
    if (row == 1)
        return 0
    end

    score = 0
    for index in (row-1):-1:1
        score += 1
        if (grid[row, col] <= grid[index, col])
            break
        end
    end

    return score
end

# If it's in the bottom row, the score looking down is 0
function getbottomscore(grid, location)
    row = location[1]
    col = location[2]
    if (row == size(grid)[1])
        return 0
    end

    score = 0
    for index in (row+1):size(grid)[1]
        score += 1
        if (grid[row, col] <= grid[index, col])
            break
        end
    end

    return score
end

day8()
