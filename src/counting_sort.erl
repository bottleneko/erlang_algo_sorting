-module(counting_sort).

-export([sort/1, sort/2]).

%%====================================================================
%% API functions
%%====================================================================

sort(List) ->
  sort(List,
    fun
      (A, B) when A == B -> 0;
      (A, B) when A < B -> 1;
      (_A, _B) -> -1
    end).

sort(List, Comparator) ->
  sort_T(List, Comparator).

%%====================================================================
%% Internal functions
%%====================================================================

sort_T(List, _Comparator) ->
  Tid = ets:new(counter, [ordered_set]),
  lists:foreach(
    fun(Elem) ->
      case ets:lookup(Tid, Elem) of
        [] ->
          ets:insert(Tid, {Elem, 1});
        [{Elem, Count}] ->
          ets:insert(Tid, {Elem, Count+1})
      end
    end, List),
  ungroup(ets:last(Tid), Tid, []).

ungroup(Iterator, Tid, Acc) ->
  case Iterator of
    '$end_of_table' ->
      Acc;
    Key ->
      [{Elem, Count}] = ets:lookup(Tid, Key),
      ungroup(ets:prev(Tid, Iterator), Tid, lists:duplicate(Count, Elem) ++ Acc)
  end.
