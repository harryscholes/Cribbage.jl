const SUITS = ['♣', '♢', '♠', '♡']
const RANKS = ['A', Char.(50:57)..., 'T', 'J', 'Q', 'K']

struct Card
    rank::Char
    value::Int64
    mask::Int
    suit::Char

    function Card(rank::Char, suit::Char; ace_high=false)
        rank in RANKS || throw(ArgumentError("Incorrect rank: $rank"))
        suit in SUITS || throw(ArgumentError("Incorrect suit: $suit"))
        idx = findfirst(x->x == rank, RANKS)
        value = idx > 10 ? 10 : idx
        if rank == 'A' && ace_high
            idx = 14
        end
        new(rank, value, idx, suit)
    end
end

function Card(str::AbstractString)
    length(str) == 2 || throw(ArgumentError("`Card` string must be of length 2"))
    Card(str[1], str[2])
end

rank(x::Card) = x.rank
value(x::Card) = x.value
mask(x::Card) = x.mask
suit(x::Card) = x.suit

Base.isless(x::Card, y::Card) = x.mask < y.mask

Base.string(x::Card) = rank(x)*suit(x)
Base.show(io::IO, x::Card) = print(io, string(x))

function deck()
    xs = sizehint!(Card[], 52)
    for s in SUITS, r in RANKS
        push!(xs, Card(r, s))
    end
    return xs
end

const DECK = deck()
