-module(insertion_sort).

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

sort_T([], _) -> [];
sort_T(List, Comparator) ->
    [IsReversed, Result] = lists:foldl(
      fun(Elem, [ReversedFlag, Acc]) ->
        [not ReversedFlag, insert_T(ReversedFlag, Elem, Acc, Comparator)]
      end, [true, [hd(List)]], tl(List)),
    if
      IsReversed ->
        lists:reverse(Result);
      true ->
        Result
    end.


insert_T(true = _IsReversede, Elem, SortedList, Comparator) ->
  io:format("Insertion elem: ~p list ~p~n", [Elem, SortedList]),
  [Added, WithElemList] = lists:foldl(
    fun(AccElem, [Flag, Acc]) ->
      case Comparator(AccElem, Elem) of
        -1 ->
          io:format("-1 flag: ~p, elem: ~p, accelem: ~p, acc: ~p~n", [Flag, Elem, AccElem, Acc]),
          [Flag, [AccElem|Acc]];
        _ when Flag ->
          io:format("FLAG flag: ~p, elem: ~p, accelem: ~p, acc: ~p~n", [Flag, Elem, AccElem, Acc]),
          [Flag, [AccElem|Acc]];
        _ ->
          io:format("LAST flag: ~p, elem: ~p, accelem: ~p, acc: ~p~n", [Flag, Elem, AccElem, Acc]),
          [true, [AccElem | [Elem | Acc]]]
      end
    end, [false, []], SortedList),
  add_elem_if_needed(not Added, Elem, WithElemList);
insert_T(false, Elem, SortedList, Comparator) ->
  [Added, WithElemList] = lists:foldl(
    fun(AccElem, [Flag, Acc]) ->
      case Comparator(AccElem, Elem) of
        1 ->
          [Flag, [AccElem|Acc]];
        _ when Flag ->
          [Flag, [AccElem|Acc]];
        _ ->
          [true, [AccElem | [Elem | Acc]]]
      end
    end, [false, []], SortedList),
  add_elem_if_needed(not Added, Elem, WithElemList).

add_elem_if_needed(Needed, Elem, List) ->
  if
    Needed ->
      [Elem|List];
    true ->
      List
  end.
