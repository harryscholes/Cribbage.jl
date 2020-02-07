isfifteen(cs::Vector{Card}) = sum(value, cs) == 15

score_fifteens(s::Show) = sum(map(n->count(isfifteen, combinations(cards(s), n)) * 2, 2:5))

ispair(x::Card, y::Card) = rank(x) == rank(y)

score_pairs(s::Show) = count(xy->ispair(xy...), combinations(cards(s), 2)) * 2

function score_flush(s::Show)
    if length(unique!(suit.(cards(s)))) == 1
        return 5
    elseif length(unique!(suit.(hand(s)))) == 1
        return 4
    end
    return 0
end

function isrun(cs::Vector{Card})
    flag = true
    for i in 1:length(cs) - 1
        if mask(cs[i+1]) - mask(cs[i]) != 1
            flag = false
            break
        end
    end

    # Account for 'Ace high' runs where Aces occurs after a King
    if !flag
        has_king = false
        for c in cs
            if rank(c) == 'K'
                has_king = true
            end
        end

        # `cs` is always sorted, so the low-Ace will be at index 1
        if has_king && rank(cs[1]) == 'A'
            push!(cs, Card('A', suit(cs[1]), ace_high=true))
            deleteat!(cs, 1)
            # Recursively call `isrun` until all low-Aces have been converted to high-Aces
            return isrun(cs)
        end
    end
    return flag
end

function score_runs(s::Show)
    # Sort the cards by `mask` value because `combinations` always maintains the order of
    # elements in the iterable
    cs = sort!(cards(s))

    # 5-card runs are the maximum and only run
    if isrun(cs)
        return 5
    end

    seen = Set{Vector{Card}}()
    t = 0

    for xs in combinations(cs, 4)
        if isrun(xs)
            t += 4
            # Store 3-card constituent runs of any 4-card runs, so we don't double count
            push!(seen, xs[1:3])
            push!(seen, xs[2:4])
        end
    end

    for xs in combinations(cs, 3)
        # Score any 3-card runs that were not constituent runs of any 4-card runs
        if xs ∉ seen && isrun(xs)
            t += 3
        end
    end

    return t
end

function score_jack(s::Show)
    x = suit(cut(s))
    # 'One for his head and one for his heels' is not scored as part of the hand
    # if rank(cut(s)) == 'J'
    #     return 2
    # end
    for c in hand(s)
        if rank(c) == 'J' && suit(c) == x
            return 1
        end
    end
    return 0
end

function score(s::Show)
    t = 0
    t += score_fifteens(s)
    t += score_pairs(s)
    t += score_runs(s)
    t += score_flush(s)
    t += score_jack(s)
    return t
end

function all_hands(f::Function)
    return vec(map(Iterators.product(combinations(DECK, 5), 1:5)) do (cs, i)
        s = Show(cs[Not(i)], cs[i])
        f(s)
    end)
end
