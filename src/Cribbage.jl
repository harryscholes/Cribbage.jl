module Cribbage

export
    Rank,
    Suit,
    Card,
    rank,
    value,
    mask,
    suit,
    ace_high,
    SUITS,
    RANKS,
    ♡, ♠, ♢, ♣,
    A, T, J, Q, K,
    A♡, A♠, A♢, A♣,
    T♡, T♠, T♢, T♣,
    J♡, J♠, J♢, J♣,
    Q♡, Q♠, Q♢, Q♣,
    K♡, K♠, K♢, K♣,
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
