using Test
using Cribbage

using Cribbage: score_fifteens, score_runs, score_pairs, score_jack, score_flush, _Hand

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
    h = rand(_Hand)
    @test length(hand(h)) == 4

    s = rand(Hand)
    @test length(hand(s)) == 4
    @test cut(s) isa Card
end

@testset "scores" begin
    s = Hand([7♣, 8♣, 7♡, 8♡], 7♠)
    @test score_fifteens(s) == 12
    @test score_pairs(s) == 8
    @test score(s) == 20

    s = Hand([T♣, 4♣, A♡, 8♡], 7♠)
    @test score_fifteens(s) == 4
    @test score(s) == 4

    s = Hand([7♣, 8♣, 7♡, 8♡], 9♠)
    @test score_fifteens(s) == 8
    @test score_pairs(s) == 4
    @test score_runs(s) == 12
    @test score(s) == 24

    s = Hand([2♣, 3♣, 4♣, 5♣], 6♣)
    @test score_flush(s) == 5
    @test score_runs(s) == 5
    @test score_fifteens(s) == 4
    @test score(s) == 14

    s = Hand([2♣, 3♣, 4♣, 5♣], 6♡)
    @test score_flush(s) == 4
    @test score_runs(s) == 5
    @test score_fifteens(s) == 4
    @test score(s) == 13

    s = Hand([2♣, 3♣, 4♡, 5♣], 6♡)
    @test score_flush(s) == 0
    @test score_runs(s) == 5
    @test score_fifteens(s) == 4
    @test score(s) == 9

    s = Hand([2♣, 3♣, 4♣, 5♣], 4♡)
    @test score_flush(s) == 4
    @test score_runs(s) == 8
    @test score_fifteens(s) == 2
    @test score_pairs(s) == 2
    @test score(s) == 16

    s = Hand([T♣, J♣, Q♣, K♣], A♡)
    @test score_runs(s) == 5
    @test score_flush(s) == 4
    @test score(s) == 9

    s = Hand([Q♣, J♣, Q♣, K♣], A♡)
    @test score_runs(s) == 8
    @test score_flush(s) == 4
    @test score_pairs(s) == 2
    @test score(s) == 14

    s = Hand([Q♣, J♣, A♣, K♣], A♡)
    @test score_runs(s) == 8
    @test score_flush(s) == 4
    @test score_pairs(s) == 2
    @test score(s) == 14

    # Best hand
    s = Hand([5♣, 5♢, 5♠, J♡], 5♡)
    score(s) == 29
    @test score(s) == 29

    # Second-best hands
    s = Hand([5♣, 5♢, 5♠, 5♡], J♡)
    @test score(s) == 28

    s = Hand([5♣, 5♢, T♡, 5♡], 5♠)
    @test score(s) == 28
end
