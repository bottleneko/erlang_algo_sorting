-module(selection_sort).

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
  sort_T([], List, Comparator).

%%====================================================================
%% Internal functions
%%====================================================================

sort_T(SortedList, [], _Comparator) ->
  lists:reverse(SortedList);
sort_T(SortedList, List, Comparator) ->
  [Min | Tail] = lists:foldl(
    fun(Elem, [CurrentMin | T] = _Acc) ->
      case Comparator(Elem, CurrentMin) of
        0 ->
          [CurrentMin | [Elem | T]];
        1 ->
          [Elem | [CurrentMin | T]];
        -1 ->
          [CurrentMin | [Elem | T]]
      end
    end, [hd(List)], tl(List)),
  sort_T([Min|SortedList], Tail, Comparator).

