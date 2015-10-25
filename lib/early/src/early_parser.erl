-module(early_parser).

-export([tokenize/1]).

tokenize({String, _Line, _Column}) ->
  {ok, {word, String}, {}}.