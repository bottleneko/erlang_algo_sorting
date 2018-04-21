-module(quick_sort).

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

sort_T([], _Comparator) -> [];
sort_T([H|T], Comparator) ->
  {Greater, Less} = lists:partition(
    fun(Element) ->
      case Comparator(Element, H) of
        1 -> true;
        _ -> false
      end
    end, T),
  sort_T(Greater, Comparator) ++ [H] ++ sort_T(Less, Comparator).