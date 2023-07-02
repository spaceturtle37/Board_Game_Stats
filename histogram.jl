using DataFrames
using Random
using BenchmarkTools
using StatsBase

const hand_size = 8
const n_charges = 2
const n_players = 4

struct Player
    name::String
    charges::Vector{Int}
        # n_positives '+'::int
        # n_negatives '-'::int
end

struct Game
    players::Vector{Player}
end

function deal_equal_hand(player::Player)
    hand = [hand_size/n_charges for nc in 1:n_charges]
    push!(player.charges, hand)
end

function deal_random_hand(player::Player)
    rands = rand!((1, n_charges), zeros(n_players))
    dict = countmap(rands)
    hand = [dict[k] for f in 1:n_charges]
    push!(player.charges, hand)
end

players_list = ["Alice", "Bob", "Charlie", "Doug", "Evan", "Faucci"]
players_list = players_list[1:n_players]

players = [Player(name, [0, 0]) for name in players_list]

game = Game(players)

println(game.players[2].charges)