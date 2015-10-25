-module(early_parser_test).
-include_lib("eunit/include/eunit.hrl").

tokenize(String) ->
  {ok, Result, _Rest} = early_parser:tokenize({String, 1, 1}),
  Result.

tokenize_ascii_word_test() ->
  {word, "hello"} = tokenize("hello").

tokenize_spanish_word_test() ->
  {word, "güiño"} = tokenize("güiño").

tokenize_japanese_test() ->
  {word, "こんにちは"} = tokenize("こんにちは").
