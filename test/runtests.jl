using Test
using Cribbage

using Cribbage: score_fifteens, score_runs, score_pairs, score_jack, score_flush

@testset "card" begin
    c = Card("A♠")
    @test c == Card("A♠")
    @test c == Card('A', '♠')
    @test c == A♠
    @test rank(c) == Rank('A')
    @test rank(c) == A
    @test suit(c) == Suit('♠')
    @test suit(c) == ♠
    @test mask(c) == 1
    @test value(c) == 1
    @test A♠ < 2♠
    @test A♠ < 4♡
    @test Q♠ < K♠
    @test K♠ > Q♠
    @test K♠ > Q♠
end

@testset "deck" begin
    @test length(deck()) == 52
    @test length(unique!(deck())) == 52
    @test length(DECK) == 52
end

@testset "hand" begin
    h = rand(Hand)
    @test length(hand(h)) == 4

    s = rand(Show)
    @test length(hand(s)) == 4
    @test cut(s) isa Card
end

@testset "scores" begin
    s = Show([7♣, 8♣, 7♡, 8♡], 7♠)
    @test score_fifteens(s) == 12
    @test score_pairs(s) == 8
    @test score(s) == 20

    s = Show([T♣, 4♣, A♡, 8♡], 7♠)
    @test score_fifteens(s) == 4
    @test score(s) == 4

    s = Show([7♣, 8♣, 7♡, 8♡], 9♠)
    @test score_fifteens(s) == 8
    @test score_pairs(s) == 4
    @test score_runs(s) == 12
    @test score(s) == 24

    s = Show([2♣, 3♣, 4♣, 5♣], 6♣)
    @test score_flush(s) == 5
    @test score_runs(s) == 5
    @test score_fifteens(s) == 4
    @test score(s) == 14

    s = Show([2♣, 3♣, 4♣, 5♣], 6♡)
    @test score_flush(s) == 4
    @test score_runs(s) == 5
    @test score_fifteens(s) == 4
    @test score(s) == 13

    s = Show([2♣, 3♣, 4♡, 5♣], 6♡)
    @test score_flush(s) == 0
    @test score_runs(s) == 5
    @test score_fifteens(s) == 4
    @test score(s) == 9

    s = Show([2♣, 3♣, 4♣, 5♣], 4♡)
    @test score_flush(s) == 4
    @test score_runs(s) == 8
    @test score_fifteens(s) == 2
    @test score_pairs(s) == 2
    @test score(s) == 16

    s = Show([T♣, J♣, Q♣, K♣], A♡)
    @test score_runs(s) == 5
    @test score_flush(s) == 4
    @test score(s) == 9

    s = Show([Q♣, J♣, Q♣, K♣], A♡)
    @test score_runs(s) == 8
    @test score_flush(s) == 4
    @test score_pairs(s) == 2
    @test score(s) == 14

    s = Show([Q♣, J♣, A♣, K♣], A♡)
    @test score_runs(s) == 8
    @test score_flush(s) == 4
    @test score_pairs(s) == 2
    @test score(s) == 14

    # Best hand
    s = Show([5♣, 5♢, 5♠, J♡], 5♡)
    score(s) == 29
    @test score(s) == 29

    # Second-best hands
    s = Show([5♣, 5♢, 5♠, 5♡], J♡)
    @test score(s) == 28

    s = Show([5♣, 5♢, T♡, 5♡], 5♠)
    @test score(s) == 28
end
