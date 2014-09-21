
-module(paths).

-export([find/1,
         find_path/1,
         group_paths/1
        ]).

find(FilePath) ->
    PathMap = read_map(file:read_file(FilePath)),
    find_path(PathMap).

group_paths(Data) -> group_paths(Data, []).
group_paths([], Acc) -> Acc;
group_paths([A, B, X |Data], Acc) -> group_paths(Data, [{A, B, X} | Acc]) .

read_map(Data) ->
    group_paths(string:tokens(Data, "\n\r\t ")).

find_path(PathMap) ->
    find_path(PathMap, {0, []}, {0, []}).
find_path([], {DistA, PathA}, {DistB, PathB}) ->
    if DistA =< DistB -> {DistA, PathA};
       DistA  > DistB -> {DistB, PathB}
    end;
find_path([{A, B, X} | Rest], {DistA, PathA}, {DistB, PathB}) ->
    {NextA, NextPathA} = {DistA + A, PathA ++ [a]},
    {NextB, NextPathB} = {DistB + B, PathB ++ [b]},
    {NewDistA, NewPathA} = if
        Rest == [] -> {NextA, NextPathA};
        NextA > NextB + X -> {NextB + X, NextPathB ++ [x]};
        true -> {NextA, NextPathA}
    end,
    {NewDistB, NewPathB} = if
        Rest == [] -> {NextB, NextPathB};
        NextB > NextA + X -> {NextA + X, NextPathA ++ [x]};
        true -> {NextB, NextPathB}
    end,
    find_path(Rest, {NewDistA, NewPathA}, {NewDistB, NewPathB}).

