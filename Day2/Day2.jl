function main()
    # Read in strategy from file
    turns = []
    open("Day2.txt") do file
        turns = readlines(file)
    end

    score = 0           # Need this for part 1
    desired = 0         # Need this for part 2

    # Go through and split out the turns
    for turns in turns
        them, me = split(turns, " ")
        them = string(them)
        me = string(me)

        # Replace the letters in the strategies with names for ease of reading
        them = replace(them, "A"=>"rock", "B"=>"paper", "C"=>"scissors")
        desiredoutcome = me == "X" ? "lose" : me == "Y" ? "draw" : "win"  # For part 2, lose/draw/win
        me = replace(me, "X"=>"rock", "Y"=>"paper", "Z"=>"scissors")
        
        score += getscore(them, me) # Answer for part 1, me vs opponent
        desired += desiredscore(them, desiredoutcome) # Answer for part 2, with strategy
    end

    println("(Part 1) Total score is: $(score)")
    println("(Part 2) Desired total score is: $(desired)")
end

function getscore(theirstrategy::String, mystrategy::String)
    # Score for choosing an item
    strategyscore = mystrategy == "rock" ? 1 : mystrategy == "paper" ? 2 : 3

    # Score for winning or drawing the round
    if(theirstrategy == "rock")
        roundscore = mystrategy == "rock" ? 3 : mystrategy == "paper" ? 6 : 0
    elseif(theirstrategy == "paper")
        roundscore = mystrategy == "rock" ? 0 : mystrategy == "paper" ? 3 : 6
    else
        roundscore = mystrategy == "rock" ? 6 : mystrategy == "paper" ? 0 : 3
    end

    return strategyscore + roundscore
end

function desiredscore(theirstrategy::String, desiredoutcome::String)
    if(desiredoutcome == "lose")
        roundscore = 0
        strategy = theirstrategy == "rock" ? "scissors" : theirstrategy == "paper" ? "rock" : "paper"
    elseif(desiredoutcome == "draw")
        roundscore = 3
        strategy = theirstrategy
    else
        roundscore = 6
        strategy = theirstrategy == "rock" ? "paper" : theirstrategy == "paper" ? "scissors" : "rock"
    end

    strategyscore = strategy == "rock" ? 1 : strategy == "paper" ? 2 : 3

    return strategyscore + roundscore
end

main()
