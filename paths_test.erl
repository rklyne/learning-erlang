-module(paths_test).
-include_lib("eunit/include/eunit.hrl").
-import(paths, [group_paths/1
               ,find_path/1]).

paths_group_test() ->
    ?assertMatch([], group_paths([])),
    ?assertMatch([{1,2,3}], group_paths([1,2,3])),
    ?assertMatch([{4,5,6},{1,2,3}], group_paths([1,2,3,4,5,6])).
find_path_test_simple_test() ->
    ?assertMatch({1, [a]}, find_path([{1, 3, 0}])).
find_path_test_real_test() ->
    ?assertMatch({75, [b, x, a, x, b, b]}, find_path([{50,10,30},{5,90,20},{40,2,25},{10,8,0}])).


