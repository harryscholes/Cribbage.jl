struct _Hand
    hand::Vector{Card}
    function _Hand(cs::Vector{Card})
        length(cs) == 4 || throw(ArgumentError("`Hand` must be of length 4"))
        new(cs)
    end
end

_Hand(cs::Vector{<:AbstractString}) = _Hand(Card.(cs))
_Hand(cs::Card...) = _Hand([cs...])

hand(h::_Hand) = h.hand

Base.rand(::Type{_Hand}) = _Hand(sample(DECK, 4, replace=false))

Base.sort!(h::_Hand) = sort!(hand(h))

Base.string(h::_Hand) = "(" * join(string.(hand(h)), " ") * ")"

struct Hand
    hand::_Hand
    cut::Card
end

Hand(h::Vector{<:AbstractString}, c::AbstractString) = Hand(_Hand(h), Card(c))
Hand(h::Vector{Card}, c::Card) = Hand(_Hand(h), c)
Hand(cs::Vector{Card}) = Hand(cs[1:4], cs[5])

hand(h::Hand) = hand(h.hand)
cut(h::Hand) = h.cut
cards(h::Hand) = [hand(h)..., cut(h)]

Base.rand(::Type{Hand}) = Hand(sample(DECK, 5, replace=false))

function Base.show(io::IO, h::Hand)
    print(io, "Hand([", join(string.(hand(h)), ", "), "], ", string(cut(h)), ")")
end
