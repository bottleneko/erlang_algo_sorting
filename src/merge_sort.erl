-module(merge_sort).

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

sort_T(List, _Comparator) when length(List) < 2 -> List;
sort_T(List, Comparator) ->
  io:format("SORT ~p~n", [List]),
  {First, Second} = split(List),
  io:format("SPLIT first ~p second ~p~n", [First, Second]),
  FirstSorted = sort_T(First, Comparator),
  io:format("FIFST ~p~n", [FirstSorted]),
  SecondSorted = sort_T(Second, Comparator),
  io:format("SECOND ~p~n", [SecondSorted]),
  lists:reverse(merge(FirstSorted, SecondSorted, [], Comparator)).

split(List) ->
  lists:split(length(List) div 2, List).

merge(FirstList, [], Acc, _Compare) -> lists:reverse(FirstList) ++ Acc;
merge([], SecondList, Acc, _Compare) -> lists:reverse(SecondList) ++ Acc;
merge(FirstList = [FH|FT], SecondList = [SH|ST], Acc, Compare) ->
  case Compare(FH, SH) of
    1 ->
      merge(FT, SecondList, [FH|Acc], Compare);
    _ ->
      merge(FirstList, ST, [SH|Acc], Compare)
  end.