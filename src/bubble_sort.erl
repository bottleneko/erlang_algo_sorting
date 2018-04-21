-module(bubble_sort).

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
  sort_T(List, false, Comparator).

%%====================================================================
%% Internal functions
%%====================================================================

sort_T([], _, _) -> [];
sort_T(List, true = _IsReversed, Comparator) ->
  io:format("Call list: ~p reversed: true~n", [List]),
  [Flag | NewList] =
    lists:foldl(
      fun(Elem, [PermFlag|[H | T]] = _Acc) ->
        case Comparator(Elem, H) of
          0 ->
            [PermFlag | [H | [Elem | T]]];
          1 ->
            [if PermFlag -> true; true -> false end  | [Elem | [H | T]]];
          -1 ->
            [true| [H | [Elem | T]]]
        end
      end, [false | [hd(List)]], tl(List)),
  if
    not Flag->
      NewList;
    true ->
      sort_T(NewList, false, Comparator)
  end;
sort_T(List, false = _IsReversed, Comparator) ->
  [Flag | NewList] =
    lists:foldl(
      fun(Elem, [PermFlag|[H | T]] = _Acc) ->
        case Comparator(Elem, H) of
          0 ->
            [PermFlag | [H | [Elem | T]]];
          1 ->
            [true | [H | [Elem | T]]];
          -1 ->
            [if PermFlag -> true; true -> false end | [Elem | [H | T]]]
        end
      end, [false | [hd(List)]], tl(List)),
  if
    not Flag ->
      lists:reverse(NewList);
    true ->
      sort_T(NewList, true, Comparator)
  end.