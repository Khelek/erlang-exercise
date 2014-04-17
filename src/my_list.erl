-module(my_list).
-export([filter/2, map/2, quick_sort/1, flatten/1, reduce/3]).

filter(Fun, List) ->
    [X || X <- List, Fun(X)].
     
map(Fun, List) ->
    [Fun(X) || X <- List].

reduce(Fun, Acc, []) ->
    Acc;
reduce(Fun, Acc, [H | Tail]) ->
    reduce(Fun, Fun(H, Acc), Tail).

quick_sort([]) ->
    [];
quick_sort([OneEl]) ->
    [OneEl];
quick_sort([H | Tail]) ->
    quick_sort([X || X <- Tail, X < H]) ++ [H] ++ quick_sort([X || X <- Tail, X >= H]).

flatten(ListOfLists) ->
    lists:reverse(flatten([], ListOfLists)).

flatten(Acc, [H | Tail]) ->
    flatten(flatten(Acc, H), Tail);
flatten(Acc, []) ->
    Acc;
flatten(Acc, NoList) ->
    [NoList | Acc].

% алгебраический тип данных
% размеченное объединение множеств
% proplist
