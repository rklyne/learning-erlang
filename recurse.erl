-module(recurse).
-export([fac/1
        ,map/2
        ]).

fac(0) -> 1;
fac(N) when N > 0 -> N*fac(N-1).

map(_, []) -> [];
map(F, [H|T]) -> [F(H)|map(F, T)].

