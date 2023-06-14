# println("Hello World")

"""
A = Array{Float64}(undef, 4) 
B = Array{Float64}(undef, 4) 

println(A)
println(B)
"""

using DataFrames
using Random


# initialize the dataframe with the players as columns

n_players = 4
# list_players = ["Player $i" for i in 1:n_players]
players_list = ["Alice", "Bob", "Charlie", "Doug", "Evan", "Faucci"]
players_list = players_list[1:n_players]

df = DataFrame([player => Int[] for player in players_list])

# add columns for charges 
# could introduce more charges in the future 

charges_list = ["+" , "-"]
# charges_list = ["positive", "negative"]
charges_count = [4, 4]
starting_hand = repeat(charges_count, n_players)  
# println(hand)
# println(hand[:])
n_cards = sum(starting_hand)

# n_charges = sum(charges_count)
# n_cards = n_charges * n_players
# println(n_cards)

cols = [player * " " * charge for player in players_list for charge in charges_list]
df = DataFrame([c => Int[] for c in cols]) 

# initialize the hands
push!(df, starting_hand)

# evolve a turn 
function random_turn(df, player_number)
    n_row = nrow(df)
    n_col = ncol(df)
    n_charges = 2
    n_players = n_col/n_charges

    row = df[n_row, :]
    println(row)
    """
    for i in 1:n_players
        r=rand(1:n_charges)-1
        # println(r)
        row[i*n_charges+r] = row[i*n_charges+r] - 1 
    end
    """
    println(row)
    push!(df, row)


end

random_turn(df, 1)