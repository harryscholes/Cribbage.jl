module Cribbage

export
    SUITS,
    RANKS,
    Card,
    rank,
    value,
    mask,
    suit,
    deck,
    DECK,
    Hand,
    hand,
    Show,
    cut,
    cards,
    score,
    all_hands

using
    DataStructures,
    Combinatorics,
    StatsBase,
    InvertedIndices

include("card.jl")
include("hand.jl")
include("score.jl")

end
