const SUITS = ['♣', '♢', '♠', '♡']
const RANKS = ['A', Char.(50:57)..., 'T', 'J', 'Q', 'K']

const RANK_MASK = Dict(c => i for (i, c) in enumerate(RANKS))
const RANK_VALUE = Dict(c => i > 10 ? 10 : i for (i, c) in enumerate(RANKS))

struct Rank
    rank::Char
    value::Int64
    mask::Int64

    function Rank(rank::Char; ace_high::Bool=false)
        rank in RANKS || throw(ArgumentError("Incorrect rank: $rank"))
        value = RANK_VALUE[rank]
        mask = RANK_MASK[rank]
        if ace_high
            rank == 'A' || throw(ArgumentError("Incorrect rank: $(rank(x))"))
            mask = 14
        end
        new(rank, value, mask)
    end
end

rank(x::Rank) = x.rank
value(x::Rank) = x.value
mask(x::Rank) = x.mask

Base.string(x::Rank) = string(rank(x))
Base.show(io::IO, x::Rank) = print(io, string(x))

ace_high(x::Rank) = Rank(rank(x), ace_high=true)

struct Suit
    suit::Char

    function Suit(suit::Char)
        suit in SUITS || throw(ArgumentError("Incorrect suit: $suit"))
        new(suit)
    end
end

suit(x::Suit) = x.suit
Base.string(x::Suit) = string(suit(x))
Base.show(io::IO, x::Suit) = print(io, string(x))

struct Card
    rank::Rank
    suit::Suit
end

function Card(rank::Char, suit::Char; ace_high::Bool=false)
    Card(Rank(rank; ace_high=ace_high), Suit(suit))
end

function Card(str::AbstractString; ace_high::Bool=false)
    length(str) == 2 || throw(ArgumentError("`Card` string must be of length 2"))
    Card(str[1], str[2]; ace_high=ace_high)
end

rank(x::Card) = x.rank
value(x::Card) = value(rank(x))
mask(x::Card) = mask(rank(x))
suit(x::Card) = x.suit

ace_high(x::Card) = Card(ace_high(rank(x)), suit(x))

Base.isless(x::Card, y::Card) = mask(x) < mask(y)

Base.string(x::Card) = string(rank(x))*string(suit(x))
Base.show(io::IO, x::Card) = print(io, string(x))

# Methods to create `Card` instances by juxtaposing `Rank` and `Suit`, or `Int` and `Suit`

function Base.:*(n::Int, s::Suit)
    2 ≤ n ≤ 9 || error("")
    return Card(Rank(Char(48+n)), s)
end

# Exports ♡, ♠, ♢, ♣,
for s in SUITS
    name = Symbol("$s")
    @eval const $name = Suit($s)
end

# Exports A, T, J, Q, K,
for r in ['A', 'T', 'J', 'Q', 'K']
    name = Symbol("$r")
    @eval const $name = Rank($r)
end

# Exports
# A♡, A♠, A♢, A♣,
# T♡, T♠, T♢, T♣,
# J♡, J♠, J♢, J♣,
# Q♡, Q♠, Q♢, Q♣,
# K♡, K♠, K♢, K♣,
for s in SUITS, r in ['A', 'T', 'J', 'Q', 'K']
    name = Symbol("$(r)$(s)")
    @eval const $name = Card(Rank($r), Suit($s))
end

function deck()
    xs = sizehint!(Card[], 52)
    for s in SUITS, r in RANKS
        push!(xs, Card(r, s))
    end
    return xs
end

const DECK = deck()
