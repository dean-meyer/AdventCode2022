function Day6()
    characters = ""
    open("Day6.txt") do file
        characters = readline(file)
    end

    # Set packet length here if you want Part 1 or Part 2 solution
    packetsize = 14

    # Time to iterate through
    parse = []
    for k = 1:packetsize
        append!(parse, characters[k])
    end
    
    # Find the start of the packet we need
    for k in (packetsize + 1):length(characters)
        popfirst!(parse)
        append!(parse, characters[k])

        if (isstartofpacket(parse))
            return "It starts at position $(k)"
        end
    end
end

function isstartofpacket(parse)
    for k in 1:length(parse)-1
        for j in k+1:length(parse)
            if(parse[k] == parse[j])
                return false
            end
        end
    end
    return true
end

println(Day6())
