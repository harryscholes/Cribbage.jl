using Cribbage

xs = all_hands(score)

maximum(xs)

count(x->x==29, xs)
count(x->x==28, xs)
count(x->x==27, xs)
count(x->x==26, xs)
count(x->x==25, xs)
count(x->x==24, xs)

using Plots

histogram(xs,
    )
