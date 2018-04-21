-module(selection_sort_SUITE).

-include_lib("common_test/include/ct.hrl").
-include_lib("eunit/include/eunit.hrl").

-compile(export_all).
-compile(nowarn_export_all).

all() ->
  [
    empty_list_test,
    identity_test,
    repeats_test,
    reverse_test
  ].

empty_list_test(_Config) ->
  ?assertEqual([], selection_sort:sort([])).

identity_test(_Config) ->
  ?assertEqual([1,2,3], selection_sort:sort([1,2,3])).

repeats_test(_Config) ->
  ?assertEqual([1,2,3,3], selection_sort:sort([1,3,2,3])).

reverse_test(_Config) ->
  ?assertEqual([1,2,3], selection_sort:sort([3,2,1])).


