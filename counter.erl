
-module(counter).

-export([create/0,
         create/1,
         next/1,
         reset/1]).

create() -> create(0).
create(Initial) -> spawn(fun() -> counter(Initial) end).

counter(Current) ->
    receive
        {Addr, next} ->
            Addr ! {next, Current},
            counter(inc(Current));
        {reset, Value} ->
            counter(Value)
    end.

inc(N) -> N + 1 .

reset(Pid) -> reset(Pid, 0).
reset(Pid, N) -> Pid ! {reset, N}.

next(Pid) ->
    Pid ! {self(), next},
    receive
        {next, N} -> N
    after 1000 -> timeout
    end.

