-module(early_parser_test).
-include_lib("eunit/include/eunit.hrl").

tokenize(String) ->
  {ok, Result, _Rest} = early_parser:tokenize({String, 1, 1}),
  Result.

smoke_test() ->
  {word, "hello"} = tokenize("hello").
