
-module(rpn).
-export([calc_tokens/1
        ,calc/1
        ,rpn_test/0]).

calc(Text) -> calc_tokens(string:tokens(Text, " ")).

calc_tokens(Input) ->
    [Answer] = lists:foldl(fun calc_tokens/2, [], Input),
    Answer.

% operators
calc_tokens("+", [R,L |S]) -> [L+R |S];
calc_tokens("-", [R,L |S]) -> [L-R |S];
calc_tokens("*", [R,L |S]) -> [L*R |S];
calc_tokens("/", [R,L |S]) -> [L/R |S];
calc_tokens("^", [R,L |S]) -> [math:pow(L, R) |S];
calc_tokens("ln", [L |S]) -> [math:log(L) |S];
calc_tokens("log10", [L |S]) -> [math:log10(L) |S];
calc_tokens("sum", S) -> [sum(S)];
calc_tokens("prod", S) -> [prod(S)];
calc_tokens(N, S) -> [read_number(N) |S].

read_number(Text) ->
    case string:to_float(Text) of
        {N,[]} -> N;
        _ -> list_to_integer(Text)
    end.

sum(L) -> lists:foldl(fun(A,B) -> A+B end, 0, L).
prod(L) -> lists:foldl(fun(A,B) -> A*B end, 1, L).

rpn_test() ->
    5 = calc("2 3 +"),
    87 = calc("90 3 -"),
    -4 = calc("10 4 3 + 2 * -"),
    -2.0 = calc("10 4 3 + 2 * - 2 /"),
    ok = try
        calc("90 34 12 33 55 66 + * - +")
    catch
        error:{badmatch,[_|_]} -> ok
    end,
    4037 = calc("90 34 12 33 55 66 + * - + -"),
    8.0 = calc("2 3 ^"),
    true = math:sqrt(2) == calc("2 0.5 ^"),
    true = math:log(2.7) == calc("2.7 ln"),
    true = math:log10(2.7) == calc("2.7 log10"),
    50 = calc("10 10 10 20 sum"),
    10.0 = calc("10 10 10 20 sum 5 /"),
    1000.0 = calc("10 10 20 0.5 prod"),
    ok.

