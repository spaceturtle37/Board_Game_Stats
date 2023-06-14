# println("Hello World")

"""
A = Array{Float64}(undef, 4) 
B = Array{Float64}(undef, 4) 

println(A)
println(B)
"""

using DataFrames

# initialize the dataframe with the players as columns

n_players = 4
# list_players = ["Player $i" for i in 1:n_players]
list_players = ["Alice", "Bob", "Charlie", "Doug", "Evan", "Faucci"]
list_players = list_players[1:n_players]
# println(list_players)
# println(length(list_players))

df = DataFrame([name => Int[] for name in list_players])

# add columns for charges 
n_positive = 4
n_negative = 4
n_charges = n_positive + n_negative 
n_cards = n_charges * n_players

# df = DataFrame() 


# initiliaze the hand
# df[:]