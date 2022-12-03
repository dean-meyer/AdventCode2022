function main()
    rucks = []
    open("Day3.txt") do file
        rucks = readlines(file)
    end

    # Part 1, total priority
    totalpriority = 0
    for ruck in rucks
        len::Int = length(ruck)
        compartments = (ruck[begin:Int(len/2)], ruck[Int((len/2) + 1):end])
        
        totalpriority += getpriority(getmatch(compartments))
    end

    println("Sum of priorities of items in both compartments is: $(totalpriority)")

    #Part 2, badge priority
    badgepriority = 0
    countelves = length(rucks)
    for i in 1:3:countelves
        badgepriority += getpriority(getbadge((rucks[i], rucks[i+1], rucks[i+2])))
    end

    println("Sum of the priorities of the badges for each group of 3 is: $(badgepriority)")
end


function getmatch(compartments)
    # Finds the single item (upper or lower case letter, which occurs in both compartments)
    for item in compartments[1]
        if occursin(item, compartments[2])
            return item
        end
    end
end


function getpriority(item)
    if isuppercase(item)
        # Subtract 38 from the integer value for ASCII encoding (A = 65, 65-27=38) to start priority at 27
        return Int(item) - 38
    else
        # Subtract 96 from the integer value for ASCII encoding (a = 97, 97-96=1) to start priority at 1
        return Int(item) - 96
    end
end


function getbadge(rucks)
    # Finds the single item (upper or lower case letter) which occurs in all 3 rucksacks
    for item in rucks[1]
        if (occursin(item, rucks[2]) && occursin(item, rucks[3]))
            return item
        end
    end
end


main()
