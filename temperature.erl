
% Define my crappy module

-module(temperature).
-export([mytemp/0,
         as_kelvin/1]).

% A function definition
mytemp() -> 
    % A tuple
    {8, celsius} .

% A conversion to kelvin
as_kelvin({Temp_c, celsius}) ->
    {Temp_c + 253, kelvin}.



