# Cribbage.jl

This package implements the card game [Cribbage](https://en.wikipedia.org/wiki/Cribbage) in Julia.

### Installation

```julia
julia> ] add https://github.com/harryscholes/Cribbage.jl


```

### API

Because this is Julia, we can do some really cool things:

```julia
julia> using Cribbage

julia> A, T, J, Q, K # rank constants
(A, T, J, Q, K)

julia> ♣, ♢, ♠, ♡ # suit constants
(♣, ♢, ♠, ♡)

julia> A♠, T♣, J♡, Q♢, K♠ # picture card constants
(A♠, T♣, J♡, Q♢, K♠)

julia> 2♣, 4♢, 6♠, 8♡ # instantiate non-picture cards by overloading multiplication of `Int` and `Suit`
(2♣, 4♢, 6♠, 8♡)

julia> typeof.([A, ♠, A♠]) # intuitive type system
3-element Array{DataType,1}:
 Rank
 Suit
 Card

julia> 9♡ < T♢
true

julia> A♡ < ace_high(A♣)
true

julia> deck()
52-element Array{Card,1}:
 A♣
 2♣
 3♣
 4♣
 5♣
 6♣
 ⋮
 8♡
 9♡
 T♡
 J♡
 Q♡
 K♡

julia> best_hand = Hand([5♣, 5♢, 5♠, J♡], 5♡)
Hand([5♣, 5♢, 5♠, J♡], 5♡)

julia> score(best_hand)
29

julia> second_best_hand = score(Hand([5♣, 5♢, 5♠, 5♡], J♡))
28

julia> Cribbage.isrun([A♠, 2♡, 3♢])
true

julia> Cribbage.isrun([Q♣, K♡, A♠]) # knows to make ace high
true

julia> Cribbage.isrun([J♢, Q♣, A♠]) # needs a King for a run
false

julia> all_hands(score) # distribution of scores for all possible hands. NB expensive


```

_Issues and PRs very welcome_
