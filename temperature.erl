
% Define my crappy module

-module(temperature).
-export([mytemp/0,
         as_kelvin/1,
         int_to_celsius/1,
         int_to_kelvin/1,
         int_to_farenheit/1]).

% A function definition
mytemp() -> 
    % A tuple
    int_to_celsius(8).

int_to_celsius(Int) ->
    {Int, celsius} .

int_to_kelvin(Int) ->
    {Int, kelvin} .

int_to_farenheit(Int) ->
    {Int, farenheit} .

% A conversion to celsius
as_celsius({Temp_f, farenheit}) ->
    {(Temp_f - 32) *5/9, celsius}.

% A conversion to kelvin
as_kelvin({Temp_c, celsius}) ->
    {Temp_c + 253, kelvin};
as_kelvin(Temp) ->
    as_kelvin(as_celsius(Temp)).



