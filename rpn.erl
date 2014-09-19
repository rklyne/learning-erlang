
-module(rpn).
-export([calc/1]).

calc(Input) -> calc(Input, initial_state()).

initial_state() -> [].

% Case where we're done
calc([], [Result]) -> Result;
% Case where no result is on the stack
calc([], []) -> throw(no_result);
% case where there is excess data on the stack.
calc([], [_|_]) -> throw(excess_results_on_stack);
% operators
calc([plus|Input], [L,R|Stack]) -> calc(Input, [L+R|Stack]);
calc([minus|Input], [L,R|Stack]) -> calc(Input, [L-R|Stack]);
calc([times|Input], [L,R|Stack]) -> calc(Input, [L*R|Stack]);
calc([divide|Input], [L,R|Stack]) -> calc(Input, [L/R|Stack]);
% Read number onto the stack
calc([N|Input], Stack) -> calc(Input, [N|Stack]).

