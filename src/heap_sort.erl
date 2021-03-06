-module(heap_sort).

-export([sort/1]).

%%====================================================================
%% API functions
%%====================================================================

sort(List) ->
  Heap = binary_heap:from_list(List),
  binary_heap:to_list(Heap).

%%====================================================================
%% Internal functions
%%====================================================================
