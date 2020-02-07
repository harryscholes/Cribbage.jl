struct Hand
    hand::Vector{Card}
    function Hand(cs::Vector{Card})
        length(cs) == 4 || throw(ArgumentError("`Hand` must be of length 4"))
        new(cs)
    end
end

Hand(cs::Vector{<:AbstractString}) = Hand(Card.(cs))

hand(h::Hand) = h.hand

Base.rand(::Type{Hand}) = Hand(sample(DECK, 4, replace=false))

Base.sort!(h::Hand) = sort!(hand(h))

Base.string(h::Hand) = "(" * join(string.(hand(h)), " ") * ")"
Base.show(io::IO, h::Hand) = print(io, string(h))

struct Show
    hand::Hand
    cut::Card
end

Show(h::Vector{<:AbstractString}, c::AbstractString) = Show(Hand(h), Card(c))
Show(h::Vector{Card}, c::Card) = Show(Hand(h), c)
Show(cs::Vector{Card}) = Show(cs[1:4], cs[5])

hand(s::Show) = s.hand.hand
cut(s::Show) = s.cut
cards(s::Show) = [hand(s)..., cut(s)]

Base.rand(::Type{Show}) = Show(sample(DECK, 5, replace=false))

Base.show(io::IO, s::Show) = print(io, string(s.hand) * "  " * string(cut(s)))
