
import Base: size
import DataFrames: DataFrame

"""
    AbstractCards

Parent type for all `Cards`.
"""
abstract type AbstractCards end

initialize_random_cards!(cards::AbstractCards, args...) = throw(MethodError(initialize_random_cards!, (cards, args...)))
add_hand!(cards::AbstractCards, args...) = throw(MethodError(add_hand!, (cards, args...)))

"""
    ChargeCards

Container to hold time records of all charge cards during a game.
There may be `N` colors of charges.
"""
struct ChargeCards{T} <: AbstractCards
    time_records::Vector{Vector{T}}

    function ChargeCards{T}(N::Integer) where T
        @assert N ≥ one(N) "Number of charges must be at least two. $N given. Gravitons are fake..."
        return new( [ zeros(T, 0) for _ ∈ 1:N ] )
    end
end

ChargeCards(args...) = ChargeCards{Int8}(args...)

ncolors(cards::ChargeCards) = length(cards.time_records)

Base.size(cards::ChargeCards, col) = length(cards.time_records[col])
Base.size(cards::ChargeCards) = (size(cards, 1), ncolors(cards))

function add_hand!(cards::ChargeCards, color_vector)
    @assert ncolors(cards) == length(color_vector) "Supplied vector is of a different length than $(ncolors(cards))."
    for col ∈ eachindex(color_vector)
        push!(cards.time_records[col], color_vector[col])
    end
end

function initialize_random_cards!(cards::ChargeCards{T}, cards_per_hand = 10) where T
    randomizer = cards_per_hand ÷ ncolors(cards)
    @assert cards_per_hand / ncolors(cards) == randomizer "The cards per hand is not a perfect multiple of the colors."
    add_hand!(cards, fill(T(randomizer), ncolors(cards)))
    # [randomizer for _ ∈ 1:ncolors(cards)]
    return cards
end

const two_color_labels = ["+", "-"]
const three_color_labels = ["cyan", "magenta", "yellow"]

function DataFrame(cards::ChargeCards, labels)
    @assert length(labels) == ncolors(cards) "Length of input lables need to match the number of colors."
    return DataFrame( [cards.time_records...], labels )
end

function DataFrame(cards::ChargeCards)
    @assert ncolors(cards) == 2 || ncolors(cards) == 3 "You must supply a set of color labels since the number of colors equals $(ncolors(cards)) (> 2,3)"
    return DataFrame(cards, ncolors(cards) == 2 ? two_color_labels : three_color_labels)
end