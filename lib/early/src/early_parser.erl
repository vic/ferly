-module(early_parser).
-include("early.hrl").
-export([tokenize/1]).

%% Spaces
-define(is_horizontal_space(S), ((S == $\s) orelse (S == $\t))).
-define(is_vertical_space(S), ((S == $\r) orelse (S == $\n))).
-define(is_space(S), (?is_horizontal_space(S) orelse ?is_vertical_space(S))).

-define(is_word_item(S), (not ?is_space(S))).


tokenize({String, _Line, _Column}) ->
  case tokenize_word(String) of
    {ok, Word, Rest} -> 
      {ok, {word, Word}, {rest, Rest}};
    {_, Rest} ->
      {err, Rest}
  end.

tokenize_word([S|String]) when ?is_word_item(S) ->
  tokenize_word_acc([S], String);
  
tokenize_word(Rest) -> {error, Rest}.

tokenize_word_acc(H, [S|String]) when
    ?is_word_item(H) andalso ?is_word_item(S) ->
  tokenize_word_acc([S] ++ H, String);

tokenize_word_acc(RWord, Rest) ->
  {ok, lists:reverse(RWord), Rest}.
