-module(my_list_tests).

-include_lib("eunit/include/eunit.hrl").

filter_test() ->
    ?assertEqual([2,4,6], my_list:filter(fun(E) -> E rem 2 == 0 end, [1,2,3,4,5,6])).

map_test() ->
    ?assertEqual([2,4,6,8,10,12], my_list:map(fun(X) -> X * 2 end, [1,2,3,4,5,6])).

reduce_test() ->
    ?assertEqual(21, my_list:reduce(fun(X, Sum) -> X + Sum end, 0, [1,2,3,4,5,6])).

quick_sort_test() ->
    ?assertEqual([1,2,3,4,5,6], my_list:quick_sort([4,5,1,3,2,6])).

flatten_test() ->
    ?assertEqual([1,2,3,4,5,6,7], my_list:flatten([[1,2],3,[4],[[5],6,[7]]])).
